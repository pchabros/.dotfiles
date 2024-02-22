require("git-worktree").setup()
local telescope = require("telescope")
local set = vim.keymap.set

telescope.load_extension("git_worktree")

set("n", "<leader>gw", function()
  telescope.extensions.git_worktree.git_worktrees()
end, { desc = "List Worktrees" })

set("n", "<leader>ga", function()
  telescope.extensions.git_worktree.create_git_worktree()
end, { desc = "Add Worktree" })
