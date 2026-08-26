return {
	{
		"mason-org/mason.nvim",
		opts = {
			PATH = "append",
		},
	},

	{
		"mason-org/mason-lspconfig.nvim",
		dependencies = {
			"mason-org/mason.nvim",
			"neovim/nvim-lspconfig",
		},
		opts = {
			ensure_installed = {
				"lua_ls",
				"jdtls",
				"pyright",
				"html",
				"lemminx",
				"clangd",
			},

			automatic_enable = {
				exclude = {
					"jdtls",
				},
			},
		},
	},

	{
		"jay-babu/mason-nvim-dap.nvim",
		dependencies = {
			"mason-org/mason.nvim",
		},
		opts = {
			ensure_installed = {
				"debugpy",
				"java-debug-adapter",
				"java-test",
				"codelldb",
			},
		},
	},

	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		dependencies = {
			"mason-org/mason.nvim",
		},
		opts = {
			ensure_installed = {
				"checkstyle",
				"ruff",
				"prettier",
				"clang-format",
				"google-java-format",
			},
		},
	},
}
