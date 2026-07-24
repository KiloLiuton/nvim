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

			vim.keymap.set("n", "<leader>gr", ":Gitsigns reset_hunk<CR>", { desc = "Reset hunk" })
			vim.keymap.set("n", "<leader>gp", ":Gitsigns preview_hunk<CR>", { desc = "Preview hunk" })
			vim.keymap.set("n", "<leader>gb", ":Git blame<CR>", { desc = "Blame" })
			vim.keymap.set("n", "<leader>gc", ":G commit %<CR>", { desc = "Commit file" })
			-- Normal mode: Stages the hunk under the cursor
			vim.keymap.set("n", "<leader>gs", gitsigns.stage_hunk, { desc = "Stage git hunk" })
			-- Visual mode: Stages only the selected lines within a hunk
			vim.keymap.set("v", "<leader>gs", function()
				gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
			end, { desc = "Stage git hunk selection" })
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
