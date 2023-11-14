-- leader key
vim.g.mapleader = " "

-- split
map("n", "<leader>v", ":vsplit<cr>", { desc = "Split vertical" })
map("n", "<leader>h", ":split<cr>", { desc = "Split horizontal" })

-- buffers
map("n", "[b", ":bprevious<cr>", { desc = "Previous buffer" })
map("n", "]b", ":bnext<cr>", { desc = "Next buffer" })
map("n", "Q", ":bdelete<cr>", { desc = "Delete buffer" })

-- escape
map("i", "jk", "<esc>")
map("i", "kj", "<esc>")

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

-- move outside bracket/quote in normal mode
map("i", ";;", "<Esc>la")
map("i", "jj", "<Esc>i")

-- move highlighted lines
map("v", "K", ":m '>+1<CR>gv=gv")
map("v", "L", ":m '<-2<CR>gv=gv")

-- don't jump to the next after pressing *
map("n", "*", ":keepjumps normal! mi*`i<cr>")

-- remove highlight with one key
map("n", "h", ":noh<cr>")

-- smart paste
map("x", "P", '"_dp')

-- tmux-navigator
if os.getenv("TMUX") then
	map("n", "<C-h>", "<cmd>TmuxNavigateLeft<cr>")
	map("n", "<C-j>", "<cmd>TmuxNavigateDown<cr>")
	map("n", "<C-k>", "<cmd>TmuxNavigateUp<cr>")
	map("n", "<C-l>", "<cmd>TmuxNavigateRight<cr>")
end
