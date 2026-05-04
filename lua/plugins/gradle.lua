return {
	"oclay1st/gradle.nvim",
	cmd = { "Gradle", "GradleExec", "GradleInit", "GradleFavorites" },
	dependencies = {
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
	},
	opts = {},
	keys = {
		{ "<leader>G", desc = "+Gradle", mode = { "n", "v" } },
		{ "<leader>Gg", "<cmd>Gradle<CR>", desc = "Gradle Projects" },
		{ "<leader>Gf", "<cmd>GradleFavorites<CR>", desc = "Favorite Commands" },
	},
}
