local events = require("neo-tree.events")
local set = vim.keymap.set

local function on_move(data)
	Util.lsp.on_rename(data.source, data.destination)
end

require("neo-tree").setup({
	sources = { "filesystem", "buffers", "git_status", "document_symbols" },
	open_files_do_not_replace_types = { "terminal", "Trouble", "trouble", "qf", "Outline" },
	filesystem = {
		bind_to_cwd = false,
		follow_current_file = { enabled = true },
		use_libuv_file_watcher = true,
	},
	window = {
		mappings = {
			["<space>"] = "none",
			[";"] = "open",
			["j"] = "navigate_up",
			["l"] = 0,
		},
	},
	default_component_configs = {
		indent = {
			with_expanders = true,
			expander_collapsed = "",
			expander_expanded = "",
			expander_highlight = "NeoTreeExpander",
		},
	},
	event_handlers = {
		{ event = events.FILE_MOVED, handler = on_move },
		{ event = events.FILE_RENAMED, handler = on_move },
	},
})

vim.api.nvim_create_autocmd("TermClose", {
	pattern = "*lazygit",
	callback = function()
		if package.loaded["neo-tree.sources.git_status"] then
			require("neo-tree.sources.git_status").refresh()
		end
	end,
})

set({ "n" }, "<leader>e", function()
	require("neo-tree.command").execute({ toggle = true })
end, { desc = "Explorer NeoTree (root dir)" })
