vim.g.loaded_coqtail = 1
vim.g["coqtail#supported"] = 0

-- Kill the green wash on the checked region. syntax/coq.vim re-applies its green
-- `hi def` on load, ColorScheme, and TermResponseAll, overriding a one-shot clear.
-- Defining g:CoqtailHighlight makes coqtail call this instead, every time.
vim.cmd([[
  function! g:CoqtailHighlight() abort
    hi clear CoqtailChecked
    hi clear CoqtailSent
  endfunction
]])

require("vsrocq").setup({
  vsrocq = {
    proof = { mode = "Manual" },
  },
  lsp = {
    cmd = { "vsrocqtop" },
  },
})

local map = vim.keymap.set
map("n", "<leader>cf", "<cmd>VsRocq stepForward<cr>", { desc = "VsRocq step forward" })
map("n", "<leader>cb", "<cmd>VsRocq stepBackward<cr>", { desc = "VsRocq step backward" })
map("n", "<leader>cp", "<cmd>VsRocq interpretToPoint<cr>", { desc = "VsRocq interpret to point" })
map("n", "<leader>ce", "<cmd>VsRocq interpretToEnd<cr>", { desc = "VsRocq interpret to end" })
