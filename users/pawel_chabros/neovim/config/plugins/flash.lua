local set = vim.keymap.set

set({ "n", "x", "o" }, "m", function() require("flash").jump() end, { desc = "Flash" })
set({ "n", "x", "o" }, "M", function() require("flash").treesitter() end, { desc = "Flash Treesitter" })
