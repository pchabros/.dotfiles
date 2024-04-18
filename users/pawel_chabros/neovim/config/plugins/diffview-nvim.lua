local actions = require("diffview.actions")
require("diffview").setup({
  keymaps = {
    file_panel = {
      { "n", "k", actions.next_entry,   { desc = "Bring the cursor to the next file entry" } },
      { "n", "l", actions.prev_entry,   { desc = "Bring the cursor to the previous file entry" } },
      { "n", ";", actions.select_entry, { desc = "Open the diff for the selected entry" } },
      { "n", "j", actions.close_fold,   { desc = "Collapse fold" } },
    },
  },
})
