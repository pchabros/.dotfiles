local formatting = require("null-ls").builtins.formatting
local diagnostics = require("null-ls").builtins.diagnostics
local code_actions = require("null-ls").builtins.code_actions
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

require("null-ls").setup({
  sources = {
    code_actions.refactoring,
    code_actions.shellcheck,
    diagnostics.eslint_d.with({ diagnostics_format = "#{m} " }),
    -- diagnostics.mypy,
    diagnostics.shellcheck,
    diagnostics.yamllint,
    diagnostics.zsh,
    formatting.nixfmt,
    -- formatting.prettierd, -- not updated to Angular v17
    formatting.prettier,
    formatting.ruff_format,
    formatting.shfmt,
    formatting.stylua,
  },
  on_attach = function(client, bufnr)
    if client.supports_method("textDocument/formatting") then
      vim.api.nvim_clear_autocmds({
        group = augroup,
        buffer = bufnr,
      })
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format({ bufnr = bufnr })
        end,
      })
    end
  end,
})
