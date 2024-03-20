local harpoon = require("harpoon")
local wk = require("which-key")

harpoon:setup()

wk.register({ l = { name = "Harpoon" } }, { prefix = "<leader>" })

vim.keymap.set("n", "<leader>la", function()
  harpoon:list():append()
end, { desc = "Append" })
vim.keymap.set("n", "<leader>ll", function()
  harpoon.ui:toggle_quick_menu(harpoon:list())
end, { desc = "List" })

vim.keymap.set("n", "[l", function()
  harpoon:list():prev()
end)
vim.keymap.set("n", "]l", function()
  harpoon:list():next()
end)

local conf = require("telescope.config").values
local function toggle_telescope(harpoon_files)
  local file_paths = {}
  for _, item in ipairs(harpoon_files.items) do
    table.insert(file_paths, item.value)
  end

  require("telescope.pickers")
      .new({}, {
        prompt_title = "Harpoon",
        finder = require("telescope.finders").new_table({
          results = file_paths,
        }),
        previewer = conf.file_previewer({}),
        sorter = conf.generic_sorter({}),
      })
      :find()
end

vim.keymap.set("n", "<leader>fl", function()
  toggle_telescope(harpoon:list())
end, { desc = "Harpoon" })
