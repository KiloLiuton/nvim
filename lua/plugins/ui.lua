return {
	-- ════════════════════════════════════════════════════════════════════════════
	-- Fidget (LSP progress notifications)
	-- ════════════════════════════════════════════════════════════════════════════
	{
		"j-hui/fidget.nvim",
		opts = {},
	},
	{
		{
			"rachartier/tiny-inline-diagnostic.nvim",
			event = "VeryLazy",
			priority = 1000,
			opts = {},
		},
	},
}
