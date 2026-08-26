return {
	"oclay1st/maven.nvim",
	cmd = { "Maven", "MavenInit", "MavenExec", "MavenFavorites" },
	dependencies = {
		"MunifTanjim/nui.nvim",
	},
	opts = {},
	keys = {
		{ "<leader>M", desc = "+Maven", mode = { "n", "v" } },
		{ "<leader>Mm", "<cmd>Maven<CR>", desc = "Maven Projects" },
		{ "<leader>Mf", "<cmd>MavenFavorites<CR>", desc = "Favorite Commands" },
	},
}
