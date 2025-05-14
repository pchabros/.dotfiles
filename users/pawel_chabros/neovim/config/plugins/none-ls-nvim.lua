local formatting = require("null-ls").builtins.formatting
local diagnostics = require("null-ls").builtins.diagnostics
local code_actions = require("null-ls").builtins.code_actions
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

require("null-ls").setup({
  sources = {
    code_actions.refactoring,
    code_actions.statix,
    diagnostics.statix,
    -- formatting.prettierd, -- not updated to Angular v17
    formatting.prettier,
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
