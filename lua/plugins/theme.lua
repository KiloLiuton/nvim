return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000, -- load before other plugins
		opts = {
			flavour = "mocha", -- latte, frappe, macchiato, mocha, nvim
		},
		init = function()
			vim.cmd.colorscheme("catppuccin")
		end,
	},
}
