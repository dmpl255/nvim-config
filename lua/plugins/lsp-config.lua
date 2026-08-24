return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup({
				ensure_installed = {
					"mypy",
					"ruff",
					"black",
					"debugpy",
					"prettier",
					"lemminx",
					"clangd",
					"clangd-format",
				},
				PATH = "append",
			})
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = { "lua_ls", "jdtls", "pyright", "html" },
				automatic_enable = {
					exclude = { "jdtls" },
				},
			})
		end,
	},
	{
		"jay-babu/mason-nvim-dap.nvim",
		config = function()
			require("mason-nvim-dap").setup({
				ensure_installed = { "java-debug-adapter", "java-test", "codelldb" },
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			vim.lsp.config("lua_ls", {
				capabilities = capabilities,
			})

			vim.lsp.enable("lua_ls")

			local python_path = vim.fn.exepath("python")

			vim.lsp.config("pyright", {
				capabilities = capabilities,
				filetypes = { "python" },
				settings = {
					python = {
						pythonPath = python_path,
						analysis = {
							autoSearchPaths = true,
							useLibraryCodeForTypes = true,
							diagnosticMode = "workspace",
							typeCheckingMode = "basic",
							reportMissingTypeStubs = false,
						},
					},
				},
			})

			vim.lsp.enable("pyright")

			vim.lsp.config("lemminx", {
				capabilities = capabilities,
				filetypes = { "xml", "jsp", "jspf" },
				settings = {
					xml = {
						format = {
							enabled = true,
							splitAttributes = "preserve",
							maxLineWidth = 300,
						},
						server = {
							workDir = "~/.cache/lemminx",
						},
					},
				},
			})
			vim.lsp.enable("lemminx")

			vim.lsp.config("clangd", {
				capabilities = capabilities,
				cmd = {
					"clangd",
					"--background-index",
					"--clang-tidy",
					"--header-insertion=iwyu",
					"--completion-style=detailed",
					"--header-insertion-decorators",
				},
				settings = {
					clangd = {
						inlayHints = {
							parameterNames = true,
							designatedParameters = true,
						},
					},
				},
			})
			vim.lsp.enable("clangd")

			vim.lsp.config("html", {
				capabilities = capabilities,
				filetypes = { "html", "jsp", "htmldjango" },
			})
			vim.lsp.enable("html")

			vim.keymap.set("n", "<leader>ch", vim.lsp.buf.hover, { desc = "[C]ode [H]over Documentation" })
			vim.keymap.set("n", "<leader>cd", vim.lsp.buf.definition, { desc = "[C]ode Goto [D]efinition" })
			vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "[C]ode [A]ctions" })
			vim.keymap.set(
				"n",
				"<leader>cr",
				require("telescope.builtin").lsp_references,
				{ desc = "[C]ode Goto [R]eferences" }
			)
			vim.keymap.set(
				"n",
				"<leader>ci",
				require("telescope.builtin").lsp_implementations,
				{ desc = "[C]ode Goto [I]mplementations" }
			)
			vim.keymap.set("n", "<leader>cR", vim.lsp.buf.rename, { desc = "[C]ode [R]ename" })
			vim.keymap.set("n", "<leader>cD", vim.lsp.buf.declaration, { desc = "[C]ode Goto [D]eclaration" })
			vim.diagnostic.config({
				virtual_text = true,
				underline = true,
				signs = true,
				update_in_insert = false,
				severity_sort = true,
			})
		end,
	},
}
