vim.cmd([[packadd packer.nvim]])

return require("packer").startup(function(use)
	use("wbthomason/packer.nvim")
	use({
		"nvim-telescope/telescope.nvim",
		tag = "0.1.4",
		requires = { { "nvim-lua/plenary.nvim" } },
	})
	use("nvim-treesitter/nvim-treesitter", { run = ":TSUpdate" })
	use("windwp/nvim-ts-autotag")
	use({
		"shaunsingh/nord.nvim",
		config = function()
			vim.cmd("colorscheme nord")
		end,
	})
	use("mbbill/undotree")
	use("folke/which-key.nvim")
	use("christoomey/vim-tmux-navigator")
	use("kdheepak/lazygit.nvim")
	use({
		"VonHeikemen/lsp-zero.nvim",
		branch = "v3.x",
		requires = {
			{ "neovim/nvim-lspconfig" },
			{ "hrsh7th/nvim-cmp" },
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "hrsh7th/cmp-buffer" },
			{ "hrsh7th/cmp-path" },
			{ "saadparwaiz1/cmp_luasnip" },
			{
				"L3MON4D3/LuaSnip",
				requires = {
					{
						"rafamadriz/friendly-snippets",
						config = function()
							require("luasnip.loaders.from_vscode").lazy_load()
						end,
					},
				},
			},
		},
	})
	use({
		"windwp/nvim-autopairs",
		config = function()
			require("nvim-autopairs").setup({})
		end,
	})
	use({
		"akinsho/git-conflict.nvim",
		tag = "*",
	})
	use({
		"folke/trouble.nvim",
		requires = { "nvim-tree/nvim-web-devicons" },
	})
	use("folke/flash.nvim")
	use({
		"gbprod/cutlass.nvim",
		config = function()
			require("cutlass").setup({
				cut_key = "z",
			})
		end,
	})
	use({ "akinsho/bufferline.nvim", tag = "*" })
	use({
		"nvim-lualine/lualine.nvim",
		requires = { "nvim-tree/nvim-web-devicons", opt = true },
	})
	use({
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup()
		end,
	})
	use({
		"folke/neodev.nvim",
		config = function()
			require("neodev").setup()
		end,
	})
	use("nvimtools/none-ls.nvim")
	use("stevearc/dressing.nvim")
	use("lukas-reineke/indent-blankline.nvim")
	use("echasnovski/mini.indentscope")
	use({
		"folke/noice.nvim",
		requires = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
		},
	})
	use({
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		requires = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
		},
	})
	use("nvim-pack/nvim-spectre")
	use({ "tpope/vim-surround", requires = { "tpope/vim-repeat" } })
	use({
		"echasnovski/mini.nvim",
		config = function()
			require("mini.ai").setup()
		end,
	})
	use("lewis6991/gitsigns.nvim")
	use("RRethy/vim-illuminate")
	use("echasnovski/mini.bufremove")
end)
