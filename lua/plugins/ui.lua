return {
	-- ════════════════════════════════════════════════════════════════════════════
	-- Fidget (LSP progress notifications)
	-- ════════════════════════════════════════════════════════════════════════════
	{
		"j-hui/fidget.nvim",
		opts = {},
	},
	{
		"rachartier/tiny-inline-diagnostic.nvim",
		event = "VeryLazy",
		priority = 1000,
		opts = {},
	},
	-- {
	-- 	"folke/which-key.nvim",
	-- 	event = "VeryLazy",
	-- 	opts = {
	-- 		-- your configuration comes here
	-- 		-- or leave it empty to use the default settings
	-- 		-- refer to the configuration section below
	-- 	},
	-- 	keys = {
	-- 		{
	-- 			"<leader>?",
	-- 			function()
	-- 				require("which-key").show({ global = false })
	-- 			end,
	-- 			desc = "Buffer Local Keymaps (which-key)",
	-- 		},
	-- 	},
	-- },
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {
			preset = "helix",
			delay = 250,
			sort = { "alphanum", "local", "order", "group", "mod" },
			icons = {
				mappings = false,
				rules = false,
				breadcrumb = "»",
				separator = "→",
				group = "+",
			},
			plugins = {
				marks = true,
				registers = true,
				spelling = { enabled = false },
			},
			win = {
				border = "rounded",
				padding = { 1, 2 },
			},
			-- spec = {
			-- 	mode = { "n", "v" },
			-- 	-- Top-level quick access
			-- 	{ "<leader><space>", desc = "Find Files" },
			-- 	{ "<leader>/",       desc = "Grep" },
			-- 	{ "<leader>,",       desc = "Buffers" },
			-- 	{ "<leader>.",       desc = "Scratch" },
			-- 	{ "<leader>e",       desc = "Explorer" },
			-- 	{ "<leader>q",       desc = "Quit" },
			-- 	{ "<leader>Q",       desc = "Quit All" },
			-- 	-- Main groups
			-- 	{ "<leader>b",       group = "Buffers" },
			-- 	{ "<leader>c",       group = "Code" },
			-- 	{ "<leader>d",       group = "Diagnostics" },
			-- 	{ "<leader>f",       group = "Files" },
			-- 	{ "<leader>g",       group = "Git" },
			-- 	{ "<leader>gh",      group = "Hunks" },
			-- 	{ "<leader>l",       group = "LSP" },
			-- 	{ "<leader>m",       group = "Markdown" },
			-- 	{ "<leader>n",       group = "Notifications" },
			-- 	{ "<leader>s",       group = "Search" },
			-- 	{ "<leader>u",       group = "UI/Toggle" },
			-- 	{ "<leader>w",       group = "Windows" },
			-- 	-- Navigation groups
			-- 	{ "[",               group = "Prev" },
			-- 	{ "]",               group = "Next" },
			-- 	{ "g",               group = "Goto" },
			-- 	-- Surround (mini.surround)
			-- 	{ "gs",              group = "Surround" },
			-- },
		},
		keys = {
			{
				"<leader>?",
				function()
					require("which-key").show({ global = false })
				end,
				desc = "Buffer Keymaps",
			},
			{
				"<leader>K",
				function()
					require("which-key").show({ global = true })
				end,
				desc = "All Keymaps",
			},
		},
	},
}
