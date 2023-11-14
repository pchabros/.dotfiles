local gs = require("gitsigns")

local set = vim.keymap.set

gs.setup({
	signs = {
		add = { text = "▎" },
		change = { text = "▎" },
		delete = { text = "" },
		topdelete = { text = "" },
		changedelete = { text = "▎" },
		untracked = { text = "▎" },
	},
})

set("n", "]g", gs.next_hunk, { desc = "Next Hunk" })
set("n", "[g", gs.prev_hunk, { desc = "Prev Hunk" })
set({ "n", "v" }, "<leader>gs", ":Gitsigns stage_hunk<CR>", { desc = "Stage Hunk" })
set({ "n", "v" }, "<leader>gr", ":Gitsigns reset_hunk<CR>", { desc = "Reset Hunk" })
set("n", "<leader>gS", gs.stage_buffer, { desc = "Stage Buffer" })
set("n", "<leader>gu", gs.undo_stage_hunk, { desc = "Undo Stage Hunk" })
set("n", "<leader>gR", gs.reset_buffer, { desc = "Reset Buffer" })
set("n", "<leader>gp", gs.preview_hunk, { desc = "Preview Hunk" })
set("n", "<leader>gB", function()
	gs.blame_line({ full = true })
end, { desc = "Blame Line" })
set("n", "<leader>gd", gs.diffthis, { desc = "Diff This" })
set("n", "<leader>gD", function()
	gs.diffthis("~")
end, { desc = "Diff This ~" })
set({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", { desc = "GitSigns Select Hunk" })
