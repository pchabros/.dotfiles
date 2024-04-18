local builtin = require("telescope.builtin")
local actions = require('telescope.actions')
local action_state = require('telescope.actions.state')
local set = vim.keymap.set
local wk = require("which-key")

wk.register({ f = { name = "Telescope" } }, { prefix = "<leader>" })
set("n", "<leader><space>", builtin.git_files, { desc = "Git files" })
set("n", "<leader>ff", builtin.find_files, { desc = "All files" })
set("n", "<leader>/", builtin.live_grep, { desc = "Grep files" })
set("n", "<leader>fb", builtin.git_branches, { desc = "Branch" })
set("n", "<leader>fc", builtin.git_commits, { desc = "Commit" })
set("n", "<leader>fw", builtin.grep_string, { desc = "Grep word" })
set("n", "<leader>fo", "<cmd>TodoTelescope<cr>", { desc = "Todos" })

local truncate_large_files = function(filepath, bufnr, opts)
  local max_size = 10000
  opts = opts or {}
  filepath = vim.fn.expand(filepath)
  vim.loop.fs_stat(filepath, function(_, stat)
    if not stat then
      return
    end
    if stat.size > max_size then
      local comand = { "head", "-c", max_size, filepath }
      require("telescope.previewers.utils").job_maker(comand, bufnr, opts)
    else
      require("telescope.previewers").buffer_previewer_maker(filepath, bufnr, opts)
    end
  end)
end

require("telescope").setup({
  defaults = {
    buffer_previewer_maker = truncate_large_files,
    file_ignore_patterns = { ".Rd$", ".RDS$" },
    mappings = {
      i = {
        ["K"] = function(...)
          return require("telescope.actions").cycle_history_next(...)
        end,
        ["L"] = function(...)
          return require("telescope.actions").cycle_history_prev(...)
        end,
      },
      n = {
        ["k"] = function(...)
          require("telescope.actions").move_selection_next(...)
        end,
        ["l"] = function(...)
          require("telescope.actions").move_selection_previous(...)
        end,
      },
    },
  },
  pickers = {
    git_commits = {
      mappings = {
        i = {
          ["<C-o>"] = function()
            local entry = action_state.get_selected_entry()
            actions.close(vim.api.nvim_get_current_buf())
            vim.cmd(("DiffviewOpen %s^!"):format(entry.value))
          end,
        },
      },
    },
    git_branches = {
      mappings = {
        i = {
          ["<C-o>"] = function()
            local entry = action_state.get_selected_entry()
            actions.close(vim.api.nvim_get_current_buf())
            vim.cmd(("DiffviewOpen %s.."):format(entry.value))
          end,
        },
      },
    },
  }
})
