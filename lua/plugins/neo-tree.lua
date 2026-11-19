return {
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		lazy = false,

		dependencies = {
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			"nvim-mini/mini.icons",
		},

		opts = {
			close_if_last_window = true,

			enable_diagnostics = true,
			enable_git_status = true,
			enable_modified_markers = true,
			enable_opened_markers = true,

			default_source = "filesystem",

			source_selector = {
				winbar = true,
				statusline = false,

				sources = {
					{
						source = "filesystem",
						display_name = " 󰉓 Files ",
					},
					{
						source = "buffers",
						display_name = " 󰈚 Buffers ",
					},
					{
						source = "git_status",
						display_name = " 󰊢 Git ",
					},
				},
			},

			filesystem = {
				follow_current_file = {
					enabled = true,
				},

				hijack_netrw_behavior = "open_default",
			},

			window = {
				width = 35,
			},
		},

		keys = {
			{
				"<leader>e",
				"<cmd>Neotree toggle filesystem left<cr>",
				desc = "Toggle [E]xplorer",
			},
		},
	},
}
