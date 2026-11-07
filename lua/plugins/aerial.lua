return {
	{
		"stevearc/aerial.nvim",
		cmd = {
			"AerialToggle",
			"AerialOpen",
			"AerialClose",
			"AerialNavToggle",
		},
		opts = {
			backends = {
				"treesitter",
				"lsp",
			},

			layout = {
				default_direction = "right",
				placement = "window",
				resize_to_content = true,

				min_width = 30,
				max_width = 40,
			},

			show_guides = true,

			manage_folds = false,
		},

		keys = {
			{
				"<leader>a",
				"<cmd>AerialToggle!<cr>",
				desc = "[A]erial Outline",
			},
		},
	},
}
