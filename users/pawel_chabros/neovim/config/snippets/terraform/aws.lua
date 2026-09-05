local ls = require("luasnip")
local s = ls.snippet
local fmt = require("luasnip.extras.fmt").fmt
local i = ls.insert_node

ls.add_snippets("terraform", {
  -- Provider and data sources
  s("aws_provider", fmt([[
terraform {{
  required_version = ">= 1.6.0"

  required_providers {{
    aws = {{
      source  = "hashicorp/aws"
      version = "~> 6.62"
    }}
  }}
}}

provider "aws" {{
  region = "{}"

  default_tags {{
    tags = {{
      ManagedBy = "terraform"
      Project   = "{}"
      Environment = "{}"
    }}
  }}
}}
]], { i(1, "eu-central-1"), i(2, "var.project"), i(3, "var.environment") })),

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
  vpc_id                  = "{}"
  cidr_block              = "{}"
  availability_zone       = "{}"
  map_public_ip_on_launch = {}

  tags = {{
    Name = "{}"
  }}
}}
]],
    { i(1, "aws_vpc.this.id"), i(2, "10.0.1.0/24"), i(3, "eu-central-1a"), i(4, "false"), i(5,
      "${var.project}-${var.environment}-subnet") })),

  s("aws_internet_gateway", fmt([[
resource "aws_internet_gateway" "this" {{
  vpc_id = "{}"

  tags = {{
    Name = "{}"
  }}
}}
]], { i(1, "aws_vpc.this.id"), i(2, "${var.project}-${var.environment}-igw") })),

  s("aws_security_group", fmt([[
resource "aws_security_group" "this" {{
  name        = "{}"
  description = "{}"
  vpc_id      = "{}"

  ingress {{
    from_port   = {}
    to_port     = {}
    protocol    = "{}"
    cidr_blocks = ["{}"]
  }}

  egress {{
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }}

  tags = {{
    Name = "{}"
  }}
}}
]],
    { i(1, "${var.project}-${var.environment}-sg"), i(2, "Managed by Terraform"), i(3, "aws_vpc.this.id"), i(4, "443"), i(
    5, "443"), i(6, "tcp"), i(7, "10.0.0.0/16"), i(8, "${var.project}-${var.environment}-sg") })),

  -- EC2 instance
  s("aws_instance", fmt([[
resource "aws_instance" "this" {{
  ami           = "{}"
  instance_type = "{}"
  subnet_id     = "{}"

  tags = {{
    Name = "{}"
  }}
}}
]],
    { i(1, "ami-0c55b159cbfafe1f0"), i(2, "t3.micro"), i(3, "aws_subnet.this.id"), i(4,
      "${var.project}-${var.environment}-instance") })),

  -- S3 bucket
  s("aws_s3_bucket", fmt([[
resource "aws_s3_bucket" "this" {{
  bucket = "{}"

  tags = {{
    Name = "{}"
  }}
}}
]],
    { i(1, "${var.project}-${var.environment}-${data.aws_caller_identity.current.account_id}"), i(2,
      "${var.project}-${var.environment}") })),

  s("aws_s3_private_bucket", fmt([[
resource "aws_s3_bucket" "this" {{
  bucket = "{}"
}}

resource "aws_s3_bucket_public_access_block" "this" {{
  bucket = aws_s3_bucket.this.id
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
]], { i(1, "${var.project}-${var.environment}-${data.aws_caller_identity.current.account_id}") })),

  -- IAM role
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

  -- Lambda
  s("aws_lambda_function", fmt([[
resource "aws_lambda_function" "this" {{
  function_name = "{}"
  role          = aws_iam_role.this.arn
  runtime       = "{}"
  handler       = "{}"
  filename      = "{}"
  source_code_hash = filebase64sha256("{}")
  timeout       = {}
  memory_size   = {}
}}
]],
    { i(1, "${var.project}-${var.environment}-lambda"), i(2, "python3.12"), i(3, "lambda_function.lambda_handler"), i(4,
      "${path.module}/lambda.zip"), i(5, "${path.module}/lambda.zip"), i(6, "30"), i(7, "512") })),

  -- DynamoDB table
  s("aws_dynamodb_table", fmt([[
resource "aws_dynamodb_table" "this" {{
  name         = "{}"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "{}"

  attribute {{
    name = "{}"
    type = "S"
  }}
}}
]], { i(1, "${var.project}-${var.environment}"), i(2, "pk"), i(3, "pk") })),

  -- RDS instance
  s("aws_db_instance", fmt([[
resource "aws_db_instance" "this" {{
  identifier = "{}"
  engine     = "{}"
  instance_class = "{}"
  allocated_storage = {}
  username   = "{}"
  password   = "{}"
  vpc_security_group_ids = [{}]
  skip_final_snapshot = true
}}
]],
    { i(1, "${var.project}-${var.environment}-db"), i(2, "postgres"), i(3, "db.t3.micro"), i(4, "100"), i(5, "admin"), i(
    6, "password"), i(7, "aws_security_group.this.id") })),

  -- Common patterns
  s("tf_lifecycle", fmt([[
lifecycle {{
  create_before_destroy = {}
  prevent_destroy = {}
  ignore_changes = [{}]
}}
]], { i(1, "true"), i(2, "false"), i(3, "tags") })),
})
