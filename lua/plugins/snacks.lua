return {
	{
		"folke/snacks.nvim",

		lazy = false,
		priority = 1000,

		opts = {
			picker = {
				enabled = true,
				ui_select = true,
			},

			terminal = {
				win = {
					style = "terminal",
					position = "float",
					width = 0,
					height = 0,
					border = "none",
					backdrop = false,
				},
			},
		},

		keys = {
			{
				"<leader>FF",
				function()
					Snacks.picker.lsp_workspace_symbols()
				end,
				desc = "[F]ind Workspace Symbols",
			},
			{
				"<leader>ff",
				function()
					Snacks.picker.files()
				end,
				desc = "[F]ind [F]iles",
			},
			{
				"<leader>fg",
				function()
					Snacks.picker.grep()
				end,
				desc = "[F]ind by [G]rep",
			},
			{
				"<leader>fd",
				function()
					Snacks.picker.diagnostics()
				end,
				desc = "[F]ind [D]iagnostics",
			},
			{
				"<leader>fr",
				function()
					Snacks.picker.resume()
				end,
				desc = "[F]inder [R]esume",
			},
			{
				"<leader>f.",
				function()
					Snacks.picker.recent()
				end,
				desc = '[F]ind Recent Files (".")',
			},
			{
				"<leader>fb",
				function()
					Snacks.picker.buffers()
				end,
				desc = "[F]ind Existing [B]uffers",
			},
		},
	},
}
