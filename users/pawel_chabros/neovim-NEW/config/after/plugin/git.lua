local wk = require("which-key")
local utils = require('utils')

local map = utils.map

require('git-conflict').setup()

wk.register({ g = { name = "Git " } }, { prefix = "<leader>" })
map("n", "<leader>gg", ":LazyGit<cr>", { desc = "Lazy UI" })
map("n", "<leader>gf", ":LazyGitFilter<cr>", { desc = "Lazy filter" })
map("n", "<leader>go", ":GitConflictChooseOurs <cr>", { desc = " Ours" })
map("n", "<leader>gt", ":GitConflictChooseTheirs <cr>", { desc = " Theirs" })
map("n", "<leader>gb", ":GitConflictChooseBoth <cr>", { desc = " Both" })
map("n", "<leader>gn", ":GitConflictChooseNone <cr>", { desc = " None" })
map("n", "<leader>gc", ":GitConflictListQf <cr>", { desc = " List" })
map("n", "]x", ":GitConflictNextConflict <cr>", { desc = " Next" })
map("n", "[x", ":GitConflictPrevConflict <cr>", { desc = " Prev" })
