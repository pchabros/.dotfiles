local telescope_tabs = require("telescope-tabs")
local set = vim.keymap.set

telescope_tabs.setup({})

set({ "n" }, "<leader>ft", function()
  telescope_tabs.list_tabs()
end, { desc = "Find tab" })
