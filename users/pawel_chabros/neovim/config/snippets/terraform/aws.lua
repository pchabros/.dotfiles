local ls = require("luasnip")
local s = ls.snippet
local fmt = require("luasnip.extras.fmt").fmt
local i = ls.insert_node
local rep = require("luasnip.extras").rep

ls.add_snippets("terraform", {
  -- Provider and backend
  s("aws_provider", fmt([[
terraform {{
  required_version = ">= 1.6.0"

  required_providers {{
    aws = {{
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }}
  }}
}}

provider "aws" {{
  region = {}

  default_tags {{
    tags = {{
      Project     = var.project
      Environment = var.environment
      Owner       = var.owner
      ManagedBy   = "terraform"
    }}
  }}
}}
]], { i(1, "var.region") })),

  s("aws_backend", fmt([[
terraform {{
  backend "s3" {{
    bucket       = "{}"
    key          = "{}"
    region       = "{}"
    encrypt      = true
    use_lockfile = true
  }}
}}
]], { i(1, "my-tfstate-bucket"), i(2, "env/service/terraform.tfstate"), i(3, "eu-central-1") })),

  s("aws_base_variables", fmt([[
variable "project" {{
  description = "Project name"
  type        = string
}}

variable "environment" {{
  description = "Deployment environment"
  type        = string
}}

variable "owner" {{
  description = "Owner of the resources"
  type        = string
}}

variable "region" {{
  description = "AWS region"
  type        = string
  default     = "{}"
}}
]], { i(1, "eu-central-1") })),

  -- Data sources
  s("aws_data_region", fmt([[data "aws_region" "current" {{}}]], {})),

  s("aws_data_caller_identity", fmt([[data "aws_caller_identity" "current" {{}}]], {})),

  s("aws_data_availability_zones", fmt([[
data "aws_availability_zones" "available" {{
  state = "available"
}}
]], {})),

  -- VPC and networking
  s("aws_vpc", fmt([[
resource "aws_vpc" "this" {{
  cidr_block           = "{}"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {{
    Name = "{}"
  }}
}}
]], { i(1, "10.0.0.0/16"), i(2, "${var.project}-${var.environment}-vpc") })),

  s("aws_subnet", fmt([[
resource "aws_subnet" "this" {{
  vpc_id                  = {}
  cidr_block              = "{}"
  availability_zone       = {}
  map_public_ip_on_launch = {}

  tags = {{
    Name = "{}"
  }}
}}
]], {
    i(1, "aws_vpc.this.id"),
    i(2, "10.0.1.0/24"),
    i(3, "data.aws_availability_zones.available.names[0]"),
    i(4, "false"),
    i(5, "${var.project}-${var.environment}-subnet"),
  })),

  s("aws_internet_gateway", fmt([[
resource "aws_internet_gateway" "this" {{
  vpc_id = {}

  tags = {{
    Name = "{}"
  }}
}}
]], { i(1, "aws_vpc.this.id"), i(2, "${var.project}-${var.environment}-igw") })),

  s("aws_security_group", fmt([[
resource "aws_security_group" "this" {{
  name        = "{}"
  description = "{}"
  vpc_id      = {}

  tags = {{
    Name = "{}"
  }}
}}

resource "aws_vpc_security_group_ingress_rule" "this" {{
  security_group_id = aws_security_group.this.id
  from_port         = {}
  to_port           = {}
  ip_protocol       = "{}"
  cidr_ipv4         = "{}"
}}

resource "aws_vpc_security_group_egress_rule" "this" {{
  security_group_id = aws_security_group.this.id
  ip_protocol       = "-1"
  cidr_ipv4         = "0.0.0.0/0"
}}
]], {
    i(1, "${var.project}-${var.environment}-sg"),
    i(2, "Managed by Terraform"),
    i(3, "aws_vpc.this.id"),
    i(4, "${var.project}-${var.environment}-sg"),
    i(5, "443"),
    i(6, "443"),
    i(7, "tcp"),
    i(8, "10.0.0.0/16"),
  })),

  -- EC2 instance with AMI data source and IMDSv2
  s("aws_instance", fmt([[
data "aws_ami" "this" {{
  most_recent = true
  owners      = ["amazon"]

  filter {{
    name   = "name"
    values = ["{}"]
  }}
}}

resource "aws_instance" "this" {{
  ami           = data.aws_ami.this.id
  instance_type = "{}"
  subnet_id     = {}

  metadata_options {{
    http_tokens = "required"
  }}

  tags = {{
    Name = "{}"
  }}
}}
]], {
    i(1, "al2023-ami-*-x86_64"),
    i(2, "t3.micro"),
    i(3, "aws_subnet.this.id"),
    i(4, "${var.project}-${var.environment}-instance"),
  })),

  -- S3 bucket: private, versioned, encrypted, protected
  s("aws_s3_bucket", fmt([[
resource "aws_s3_bucket" "this" {{
  bucket = "{}"

  lifecycle {{
    prevent_destroy = true
  }}
}}

resource "aws_s3_bucket_public_access_block" "this" {{
  bucket                  = aws_s3_bucket.this.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}}

resource "aws_s3_bucket_versioning" "this" {{
  bucket = aws_s3_bucket.this.id

  versioning_configuration {{
    status = "Enabled"
  }}
}}

resource "aws_s3_bucket_server_side_encryption_configuration" "this" {{
  bucket = aws_s3_bucket.this.id

  rule {{
    apply_server_side_encryption_by_default {{
      sse_algorithm = "aws:kms"
    }}
    bucket_key_enabled = true
  }}
}}
]], { i(1, "${var.project}-${var.environment}-${data.aws_caller_identity.current.account_id}") })),

  -- IAM
  s("aws_iam_role", fmt([[
resource "aws_iam_role" "this" {{
  name = "{}"

  assume_role_policy = jsonencode({{
    Version = "2012-10-17"
    Statement = [{{
      Effect = "Allow"
      Principal = {{
        Service = "{}"
      }}
      Action = "sts:AssumeRole"
    }}]
  }})
}}
]], { i(1, "${var.project}-${var.environment}-role"), i(2, "ecs-tasks.amazonaws.com") })),

  s("aws_iam_role_policy", fmt([[
resource "aws_iam_role_policy" "this" {{
  name = "{}"
  role = aws_iam_role.this.id

  policy = jsonencode({{
    Version = "2012-10-17"
    Statement = [{{
      Effect   = "Allow"
      Action   = [{}]
      Resource = [{}]
    }}]
  }})
}}
]], { i(1, "${var.project}-${var.environment}-policy"), i(2, "\"s3:GetObject\""), i(3, "aws_s3_bucket.this.arn") })),

  -- Lambda
  s("aws_lambda_function", fmt([[
resource "aws_lambda_function" "this" {{
  function_name    = "{}"
  role             = aws_iam_role.this.arn
  runtime          = "{}"
  handler          = "{}"
  filename         = "{}"
  source_code_hash = filebase64sha256("{}")
  timeout          = {}
  memory_size      = {}
}}
]], {
    i(1, "${var.project}-${var.environment}-lambda"),
    i(2, "python3.12"),
    i(3, "lambda_function.lambda_handler"),
    i(4, "${path.module}/lambda.zip"),
    i(5, "${path.module}/lambda.zip"),
    i(6, "30"),
    i(7, "512"),
  })),

  -- DynamoDB: encrypted with PITR
  s("aws_dynamodb_table", fmt([[
resource "aws_dynamodb_table" "this" {{
  name         = "{}"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "{}"

  attribute {{
    name = "{}"
    type = "S"
  }}

  server_side_encryption {{
    enabled = true
  }}

  point_in_time_recovery {{
    enabled = true
  }}
}}
]], { i(1, "${var.project}-${var.environment}"), i(2, "pk"), rep(2) })),

  -- RDS: RDS-managed master password (no plaintext), encrypted, protected
  s("aws_db_instance", fmt([[
resource "aws_db_instance" "this" {{
  identifier                  = "{}"
  engine                      = "{}"
  engine_version              = "{}"
  instance_class              = "{}"
  allocated_storage           = {}
  db_name                     = "{}"
  username                    = "{}"
  manage_master_user_password = true
  storage_encrypted           = true
  vpc_security_group_ids      = [{}]
  skip_final_snapshot         = false

  lifecycle {{
    prevent_destroy = true
  }}
}}
]], {
    i(1, "${var.project}-${var.environment}-db"),
    i(2, "postgres"),
    i(3, "16"),
    i(4, "db.t3.micro"),
    i(5, "20"),
    i(6, "app"),
    i(7, "admin"),
    i(8, "aws_security_group.this.id"),
  })),

  -- Common patterns
  s("tf_lifecycle", fmt([[
lifecycle {{
  create_before_destroy = {}
  prevent_destroy       = {}
  ignore_changes        = [{}]
}}
]], { i(1, "true"), i(2, "false"), i(3, "tags") })),

  -- KMS
  s("aws_kms_key", fmt([[
resource "aws_kms_key" "this" {{
  description             = "{}"
  deletion_window_in_days = {}
  enable_key_rotation     = true
}}

resource "aws_kms_alias" "this" {{
  name          = "alias/{}"
  target_key_id = aws_kms_key.this.key_id
}}
]], { i(1, "${var.project}-${var.environment}"), i(2, "30"), i(3, "${var.project}-${var.environment}") })),

  -- Secrets Manager
  s("aws_secretsmanager_secret", fmt([[
resource "aws_secretsmanager_secret" "this" {{
  name       = "{}"
  kms_key_id = {}
}}

resource "aws_secretsmanager_secret_version" "this" {{
  secret_id     = aws_secretsmanager_secret.this.id
  secret_string = {}
}}
]], {
    i(1, "${var.project}-${var.environment}"),
    i(2, "aws_kms_key.this.arn"),
    i(3, "var.secret_value"),
  })),

  -- SSM Parameter (SecureString)
  s("aws_ssm_parameter", fmt([[
resource "aws_ssm_parameter" "this" {{
  name  = "{}"
  type  = "SecureString"
  value = {}
}}
]], { i(1, "/${var.project}/${var.environment}/param"), i(2, "var.param_value") })),

  -- CloudWatch
  s("aws_cloudwatch_log_group", fmt([[
resource "aws_cloudwatch_log_group" "this" {{
  name              = "{}"
  retention_in_days = {}
  kms_key_id        = {}
}}
]], { i(1, "/${var.project}/${var.environment}"), i(2, "30"), i(3, "aws_kms_key.this.arn") })),

  s("aws_cloudwatch_metric_alarm", fmt([[
resource "aws_cloudwatch_metric_alarm" "this" {{
  alarm_name          = "{}"
  comparison_operator = "{}"
  evaluation_periods  = {}
  metric_name         = "{}"
  namespace           = "{}"
  period              = {}
  statistic           = "{}"
  threshold           = {}
  alarm_actions       = [{}]
}}
]], {
    i(1, "${var.project}-${var.environment}-alarm"),
    i(2, "GreaterThanThreshold"),
    i(3, "2"),
    i(4, "CPUUtilization"),
    i(5, "AWS/EC2"),
    i(6, "300"),
    i(7, "Average"),
    i(8, "80"),
    i(9, "aws_sns_topic.this.arn"),
  })),

  -- Messaging
  s("aws_sns_topic", fmt([[
resource "aws_sns_topic" "this" {{
  name              = "{}"
  kms_master_key_id = {}
}}
]], { i(1, "${var.project}-${var.environment}"), i(2, "aws_kms_key.this.id") })),

  s("aws_sqs_queue", fmt([[
resource "aws_sqs_queue" "this" {{
  name                       = "{}"
  sqs_managed_sse_enabled    = true
  visibility_timeout_seconds = {}
  message_retention_seconds  = {}
}}
]], { i(1, "${var.project}-${var.environment}"), i(2, "30"), i(3, "345600") })),

  -- ECR
  s("aws_ecr_repository", fmt([[
resource "aws_ecr_repository" "this" {{
  name                 = "{}"
  image_tag_mutability = "IMMUTABLE"

  image_scanning_configuration {{
    scan_on_push = true
  }}

  encryption_configuration {{
    encryption_type = "KMS"
  }}
}}
]], { i(1, "${var.project}-${var.environment}") })),

  -- Routing
  s("aws_route_table", fmt([[
resource "aws_route_table" "this" {{
  vpc_id = {}

  tags = {{
    Name = "{}"
  }}
}}

resource "aws_route" "this" {{
  route_table_id         = aws_route_table.this.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = {}
}}

resource "aws_route_table_association" "this" {{
  subnet_id      = {}
  route_table_id = aws_route_table.this.id
}}
]], {
    i(1, "aws_vpc.this.id"),
    i(2, "${var.project}-${var.environment}-rt"),
    i(3, "aws_internet_gateway.this.id"),
    i(4, "aws_subnet.this.id"),
  })),

  s("aws_nat_gateway", fmt([[
resource "aws_eip" "nat" {{
  domain = "vpc"

  tags = {{
    Name = "{}"
  }}
}}

resource "aws_nat_gateway" "this" {{
  allocation_id = aws_eip.nat.id
  subnet_id     = {}

  tags = {{
    Name = "{}"
  }}
}}
]], {
    i(1, "${var.project}-${var.environment}-nat-eip"),
    i(2, "aws_subnet.this.id"),
    i(3, "${var.project}-${var.environment}-nat"),
  })),

  -- IAM policy document data source
  s("aws_iam_policy_document", fmt([[
data "aws_iam_policy_document" "this" {{
  statement {{
    effect    = "Allow"
    actions   = [{}]
    resources = [{}]
  }}
}}
]], { i(1, "\"s3:GetObject\""), i(2, "aws_s3_bucket.this.arn") })),

  -- Generic blocks
  s("tf_output", fmt([[
output "{}" {{
  description = "{}"
  value       = {}
}}
]], { i(1, "name"), i(2, "Description"), i(3, "aws_vpc.this.id") })),

  s("tf_variable", fmt([[
variable "{}" {{
  description = "{}"
  type        = {}
}}
]], { i(1, "name"), i(2, "Description"), i(3, "string") })),

  s("tf_module", fmt([[
module "{}" {{
  source  = "{}"
  version = "{}"
}}
]], { i(1, "this"), i(2, "terraform-aws-modules/vpc/aws"), i(3, "~> 5.0") })),
})
