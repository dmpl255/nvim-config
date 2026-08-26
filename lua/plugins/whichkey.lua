return {
	"folke/which-key.nvim",

	event = "VeryLazy",

	opts = {
		spec = {
			{ "<leader>/", group = "Comments" },
			{ "<leader>J", group = "Java" },
			{ "<leader>c", group = "Code" },
			{ "<leader>d", group = "Debug" },
			{ "<leader>e", group = "Explorer" },
			{ "<leader>f", group = "Find" },
			{ "<leader>G", group = "Gradle" },
			{ "<leader>M", group = "Maven" },
			{ "<leader>t", group = "Terminal" },
			{ "<leader>w", group = "Window" },
		},
	},

	keys = {
		{
			"<leader>?",
			function()
				require("which-key").show({ global = false })
			end,
			desc = "Buffer Local Keymaps",
		},
	},
}
