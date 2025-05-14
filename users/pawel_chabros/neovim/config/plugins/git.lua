local wk = require("which-key")

require('git-conflict').setup()

wk.add({ { "<leader>g", group = "Git " } })
map("n", "<leader>gg", ":LazyGit<cr>", { desc = "Lazy UI" })
map("n", "<leader>gf", ":LazyGitFilter<cr>", { desc = "Lazy filter" })
map("n", "<leader>go", ":GitConflictChooseOurs <cr>", { desc = " Ours" })
map("n", "<leader>gt", ":GitConflictChooseTheirs <cr>", { desc = " Theirs" })
map("n", "<leader>gb", ":GitConflictChooseBoth <cr>", { desc = " Both" })
map("n", "<leader>gn", ":GitConflictChooseNone <cr>", { desc = " None" })
map("n", "<leader>gc", ":GitConflictListQf <cr>", { desc = " List" })
map("n", "]x", ":GitConflictNextConflict <cr>", { desc = " Next" })
map("n", "[x", ":GitConflictPrevConflict <cr>", { desc = " Prev" })
