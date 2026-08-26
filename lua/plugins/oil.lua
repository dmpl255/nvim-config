return {
	{
		"stevearc/oil.nvim",
		lazy = false,
		dependencies = {
			{ "nvim-mini/mini.icons", opts = {} },
			{ "benomahony/oil-git.nvim", opts = {} },
		},
		opts = {
			default_file_explorer = true,
			delete_to_trash = true,

			view_options = {
				show_hidden = true,
			},
		},
		keys = {
			{
				"<leader>e",
				"<cmd>Oil<cr>",
				desc = "Open [E]xplorer",
			},
		},
	},
}
