return {
  "jose-elias-alvarez/null-ls.nvim",
  opts = function(_, opts)
    local formatting = require("null-ls").builtins.formatting
    local diagnostics = require("null-ls").builtins.diagnostics
    local code_actions = require("null-ls").builtins.code_actions
    opts.sources = vim.list_extend(opts.sources, {
      formatting.prettierd,
      formatting.beautysh,
      diagnostics.eslint_d.with({
        diagnostics_format = "#{m} ",
      }),
      diagnostics.shellcheck,
      diagnostics.yamllint,
      diagnostics.zsh,
      code_actions.shellcheck,
      code_actions.refactoring,
    })
  end,
}
