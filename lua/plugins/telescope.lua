return {
	"nvim-telescope/telescope.nvim",
	version = "*",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		"nvim-tree/nvim-web-devicons",
		"romgrk/fzy-lua-native",
	},
	config = function()
		local builtin = require("telescope.builtin")
		vim.keymap.set("n", "<C-f>", builtin.find_files, { desc = "Find files" })
		vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Live grep" })
		vim.keymap.set("n", "<leader>fb", builtin.current_buffer_fuzzy_find, { desc = "Buffer fuzzy find" })
	end,
}
