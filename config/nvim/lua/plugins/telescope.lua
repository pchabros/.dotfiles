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

return {
  "nvim-telescope/telescope.nvim",
  opts = {
    defaults = {
      buffer_previewer_maker = truncate_large_files,
      mappings = {
        i = {
          ["<C-k>"] = function(...)
            return require("telescope.actions").cycle_history_next(...)
          end,
          ["<C-l>"] = function(...)
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
  },
}
