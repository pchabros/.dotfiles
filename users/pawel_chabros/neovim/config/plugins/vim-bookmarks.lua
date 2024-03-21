local wk = require("which-key")
local set = vim.keymap.set

wk.register({ b = { name = "Bookmark" } }, { prefix = "<leader>" })

vim.g.bookmark_sign = ""

set("n", "<leader>ba", "<cmd>BookmarkToggle<CR>", { desc = "Add" })
set("n", "[b", "<cmd>BookmarkPrev<CR>", { desc = "Previous bookmark" })
set("n", "]b", "<cmd>BookmarkNext<CR>", { desc = "Next bookmark" })
set("n", "<leader>bc", "<cmd>BookmarkClear<CR>", { desc = "Clear buffer" })
set("n", "<leader>bC", "<cmd>BookmarkClearAll<CR>", { desc = "Clear all" })
set("n", "<leader>bl", "<cmd>lua require('telescope').extensions.vim_bookmarks.all()<CR>", { desc = "Bookmarks" })
set(
  "n",
  "<leader>bb",
  "<cmd>lua require('telescope').extensions.vim_bookmarks.current_file()<CR>",
  { desc = "Buffer bookmarks" }
)
