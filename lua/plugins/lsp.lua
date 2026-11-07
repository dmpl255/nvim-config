return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"saghen/blink.cmp",
		},
		config = function()
			local capabilities = require("blink.cmp").get_lsp_capabilities()
			vim.lsp.config("lua_ls", {
				capabilities = capabilities,
				root_dir = function()
					return vim.fs.root(0, { ".luarc.json", ".git", "lua" }) or vim.fn.getcwd()
				end,
				settings = {
					Lua = {
						runtime = { version = "LuaJIT" },
						diagnostics = { globals = { "vim" } },
						workspace = {
							library = vim.api.nvim_get_runtime_file("", true),
							checkThirdParty = false,
						},
						telemetry = { enable = false },
					},
				},
			})
			vim.lsp.enable("lua_ls")

			vim.lsp.config("pyright", {
				capabilities = capabilities,
				filetypes = { "python" },
				settings = {
					python = {
						pythonPath = vim.fn.exepath("python"),
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
							workDir = vim.fn.expand("~/.cache/lemminx"),
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

			vim.lsp.config("cssls", {
				capabilities = capabilities,
			})
            vim.lsp.enable("cssls")

			vim.lsp.config("tsc", {
				capabilities = capabilities,
			})
            vim.lsp.enable("tsc")

			vim.keymap.set("n", "<leader>ch", vim.lsp.buf.hover, { desc = "[C]ode [H]over Documentation" })
			vim.keymap.set("n", "<leader>cd", vim.lsp.buf.definition, { desc = "[C]ode Goto [D]efinition" })
			vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "[C]ode [A]ctions" })
			vim.keymap.set("n", "<leader>cr", function()
				Snacks.picker.lsp_references()
			end, { desc = "[C]ode Goto [R]eferences" })

			vim.keymap.set("n", "<leader>ci", function()
				Snacks.picker.lsp_implementations()
			end, { desc = "[C]ode Goto [I]mplementations" })
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
