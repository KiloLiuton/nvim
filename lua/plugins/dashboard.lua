return {
	{
		"folke/persistence.nvim",
		event = "BufReadPre",
		opts = {},
	},
	{
		"nvimdev/dashboard-nvim",
		event = "VimEnter",
		dependencies = {
			{ "nvim-tree/nvim-web-devicons", "amansingh-afk/milli.nvim", "nvim-telescope/telescope.nvim" },
		},
		opts = function()
			local splash = require("milli").load({ splash = "fire" })
			return {
				theme = "doom",
				config = {
					header = splash.frames[1], -- seed header with frame 0
					center = {
						{ icon = "🔭", desc = "Find File", key = "f", action = "Telescope find_files" },
						{ icon = " ", desc = "Restore buffers", key = "r", action = "lua require('persistence').load()", },
						{ icon = "📄", desc = "Empty", group = "Label", key = "n", action = "enew" },
						{ icon = "❌", desc = "Quit", key = "q", action = "qa" },
					},
				},
			}
		end,
		config = function(_, opts)
			require("dashboard").setup(opts)
			require("milli").dashboard({ splash = "finger", loop = true })
		end,
	},
	{
		"amansingh-afk/milli.nvim",
		lazy = false,
		config = function()
			local milli = require("milli")
			milli.dashboard({ splash = "fire", loop = true })
		end,
	},
}
