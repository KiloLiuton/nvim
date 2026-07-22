return {
	{ "tpope/vim-fugitive" },
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			local gitsigns = require("gitsigns")
			gitsigns.setup({
				signs = {
					add = { text = "█" },
					-- change = { text = "█" },
					change = { text = "▒" },
					delete = { text = "_" },
					topdelete = { text = "‾" },
					changedelete = { text = "~" },
					untracked = { text = "░" },
					-- untracked = { text = "~" },
				},
			})

			vim.keymap.set("n", "<leader>gp", ":Gitsigns preview_hunk<CR>", { desc = "Preview hunk" })
			vim.keymap.set("n", "<leader>gb", ":Gitsigns toggle_current_line_blame<CR>", { desc = "Blame line" })
			-- Jump between changes using ]c and [c
			vim.keymap.set("n", "]c", function()
				if vim.wo.diff then
					return "]c"
				end
				vim.schedule(function()
					gitsigns.nav_hunk("next")
				end)
				return "<Ignore>"
			end, { expr = true, desc = "Next Git change" })

			vim.keymap.set("n", "[c", function()
				if vim.wo.diff then
					return "[c"
				end
				vim.schedule(function()
					gitsigns.nav_hunk("prev")
				end)
				return "<Ignore>"
			end, { expr = true, desc = "Previous Git change" })
		end,
	},
}
