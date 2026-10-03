local opts = { noremap = true, silent = true, buffer = vim.api.nvim_get_current_buf() }

for _, mode in ipairs({ "n", "x" }) do
  vim.keymap.set(mode, "j", "h", opts)
  vim.keymap.set(mode, "k", "gj", opts)
  vim.keymap.set(mode, "l", "gk", opts)
  vim.keymap.set(mode, ";", "l", opts)
end

vim.keymap.set("n", "gO", function()
  require("man").show_toc()
end, opts)

vim.keymap.set(
  "n", "q", "<cmd>lclose<cr><C-w>q",
  { noremap = true, silent = true, nowait = true, buffer = opts.buffer }
)
