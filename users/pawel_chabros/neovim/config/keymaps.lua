-- leader key
vim.g.mapleader = " "

-- split
map("n", "<leader>v", "<cmd>vsplit<cr>", { desc = "Split vertical" })
map("n", "<leader>h", "<cmd>split<cr>", { desc = "Split horizontal" })

-- buffers
map("n", "[y", "<cmd>bprevious<cr>", { desc = "Previous buffer" })
map("n", "]y", "<cmd>bnext<cr>", { desc = "Next buffer" })

-- tabs
map("n", "[t", "<cmd>tabprevious<cr>", { desc = "Previous tab" })
map("n", "]t", "<cmd>tabnext<cr>", { desc = "Next tab" })
map("n", "<leader>nt", "<cmd>tabnew<cr>", { desc = "New tab" })
map("n", "T[", "<cmd>tabmove -1<cr>")
map("n", "T]", "<cmd>tabmove +1<cr>")

-- escape
map("i", "jk", "<esc>")
map("i", "kj", "<esc>")
map("t", "<Esc>", "<C-\\><C-n><C-w>h", { silent = true })

-- movement changed to jkl;
map("v", ";", "l")
map("v", "l", "k")
map("v", "k", "j")
map("v", "j", "h")
map("n", ";", "l")
map("n", "l", "k")
map("n", "k", "j")
map("n", "j", "h")

-- move lines
map("n", "K", ":m .+1<CR>==", { silent = true })
map("n", "L", ":m .-2<CR>==", { silent = true })
map("v", "K", ":m '>+1<CR>gv=gv", { silent = true })
map("v", "L", ":m '<-2<CR>gv=gv", { silent = true })

-- move outside bracket/quote in normal mode
map("i", ";;", "<Esc>la")
map("i", "jj", "<Esc>i")

-- don't jump to the next after pressing *
map("n", "*", "<cmd>keepjumps normal! mi*`i<cr>")

-- remove highlight with one key
map("n", "h", "<cmd>noh<cr>")

-- smart paste
map("x", "P", '"_dp')

-- tmux-navigator
if os.getenv("TMUX") then
  map("n", "<C-h>", "<cmd>TmuxNavigateLeft<cr>")
  map("n", "<C-j>", "<cmd>TmuxNavigateDown<cr>")
  map("n", "<C-k>", "<cmd>TmuxNavigateUp<cr>")
  map("n", "<C-l>", "<cmd>TmuxNavigateRight<cr>")
end
