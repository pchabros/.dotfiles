vim.g.rustaceanvim = {
  -- Plugin configuration
  tools = {},
  -- LSP configuration
  server = {
    on_attach = function(client, bufnr)
      local bufnr = vim.api.nvim_get_current_buf()
      vim.keymap.set("n", "<leader>ce", function()
        vim.cmd.RustLsp("explainError")
      end, { silent = true, buffer = bufnr, desc = "Explain error" })
      vim.keymap.set("n", "<leader>cd", function()
        vim.cmd.RustLsp("renderDiagnostic")
      end, { silent = true, buffer = bufnr, desc = "Diagnostics" })
    end,
    default_settings = {
      -- rust-analyzer language server configuration
      ["rust-analyzer"] = {},
    },
  },
  -- DAP configuration
  dap = {},
}
