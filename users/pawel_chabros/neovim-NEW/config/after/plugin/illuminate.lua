local il = require("illuminate")
local set = vim.keymap.set

set("n", "[h", il.goto_prev_reference, { desc = "Previous reference" })
set("n", "]h", il.goto_next_reference, { desc = "Next reference" })
