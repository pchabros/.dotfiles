local null_ls = require("null-ls")
local helpers = require("null-ls.helpers")
local methods = require("null-ls.methods")
local formatting = require("null-ls").builtins.formatting
local diagnostics = require("null-ls").builtins.diagnostics
local code_actions = require("null-ls").builtins.code_actions
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

null_ls.setup({
  sources = {
    code_actions.refactoring,
    code_actions.statix,
    diagnostics.statix,
    formatting.prettierd,
    formatting.shfmt,
  },
  on_attach = function(client, bufnr)
    if client.server_capabilities.documentFormattingProvider then
      vim.api.nvim_clear_autocmds({
        group = augroup,
        buffer = bufnr,
      })
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format({
            async = false,
            filter = function(client) return client.name ~= "ts_ls" end,
          })
        end,
      })
    end
  end,
})

local nginx_config_formatter = helpers.make_builtin({
  name = "nginx_config_formatter",
  method = methods.internal.FORMATTING,
  filetypes = { "nginx" },
  generator_opts = {
    command = "nginxfmt",
    args = { "$FILENAME" },
    to_temp_file = true,
    from_temp_file = true,
  },
  factory = helpers.formatter_factory,
})

null_ls.register(nginx_config_formatter)
