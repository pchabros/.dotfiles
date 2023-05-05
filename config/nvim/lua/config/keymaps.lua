-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local function map(mode, lhs, rhs, opts)
  local options = { noremap = true }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

local del = vim.keymap.del
local set = vim.keymap.set

-- delete some mappings
del("n", "<leader>qq")
del("n", "<leader>|")
del("n", "<leader>-")

-- split
map("n", "<leader>v", ":vsplit<cr>")
map("n", "<leader>h", ":split<cr>")

-- movement changed to jkl;
map("v", ";", "l")
map("v", "l", "k")
map("v", "k", "j")
map("v", "j", "h")
map("n", ";", "l")
map("n", "l", "k")
map("n", "k", "j")
map("n", "j", "h")

-- move faster vertically
map("n", "K", "10j")
map("n", "L", "10k")
map("v", "K", "10j")
map("v", "L", "10k")

-- move outside bracket/quote in normal mode
map("i", ";;", "<Esc>la")
map("i", "jj", "<Esc>i")

-- don't jump to the next after pressing *
map("n", "*", ":keepjumps normal! mi*`i<cr>")

-- remove highlight with one key
map("n", "h", ":noh<cr>")

-- leap
set({ "n", "x", "o" }, "m", "<Plug>(leap-forward-to)")
set({ "n", "x", "o" }, "M", "<Plug>(leap-backward-to)")
set({ "n", "x", "o" }, "gm", "<Plug>(leap-cross-window)")
