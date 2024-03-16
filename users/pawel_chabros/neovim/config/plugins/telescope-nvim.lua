local builtin = require("telescope.builtin")
local set = vim.keymap.set
local wk = require("which-key")

wk.register({ f = { name = "Telescope" } }, { prefix = "<leader>" })
set("n", "<leader><space>", builtin.git_files, { desc = "Git files" })
set("n", "<leader>ff", builtin.find_files, { desc = "Find files" })
set("n", "<leader>/", builtin.live_grep, { desc = "Grep files" })
set("n", "<leader>fb", builtin.buffers, { desc = "Find buffer" })
set("n", "<leader>fw", builtin.grep_string, { desc = "Grep word" })

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
})
