return {
	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		keys = {
			{
				"<leader>cf",
				function()
					require("conform").format({
						async = true,
						lsp_format = "fallback",
					})
				end,
				mode = "",
				desc = "[C]ode [F]ormat",
			},
		},

		opts = {
			formatters_by_ft = {
				lua = { "stylua" },
				python = { "ruff_format" },

				javascript = { "prettier" },
				typescript = { "prettier" },
				javascriptreact = { "prettier" },
				typescriptreact = { "prettier" },
				json = { "prettier" },
				jsonc = { "prettier" },
				css = { "prettier" },
				html = { "prettier" },

				c = { "clang_format" },
				cpp = { "clang_format" },

				nginx = { "nginxfmt" },
				dockerfile = { "dockerfmt" },
				yaml = { "yamlfmt" },

				groovy = { "npm-groovy-lint" },
			},

			formatters = {
				prettier = {
					prepend_args = {
						"--print-width",
						"120",
						"--no-single-attribute-per-line",
						"--bracket-same-line",
						"--html-whitespace-sensitivity",
						"ignore",
					},
				},
			},
		},
	},
}
