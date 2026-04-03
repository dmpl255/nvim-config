return {
	{
		"williamboman/mason.nvim",
		config = function()
			-- setup mason with default properties
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
			})
		end,
	},
	-- mason lsp config utilizes mason to automatically ensure lsp servers you want installed are installed
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			-- ensure that we have lua language server, typescript launguage server, java language server, and java test language server are installed. Приходится вручную устанавливать jdtls из-за блокировки lombok
			require("mason-lspconfig").setup({
				ensure_installed = { "lua_ls", "jdtls", "pyright" },
				automatic_enable = {
					exclude = { "jdtls" }, -- Исключаем jdtls, чтобы настроить его отдельно (например, через nvim-jdtls)
				},
			})
		end,
	},
	-- mason nvim dap utilizes mason to automatically ensure debug adapters you want installed are installed, mason-lspconfig will not automatically install debug adapters for us
	{
		"jay-babu/mason-nvim-dap.nvim",
		config = function()
			-- ensure the java debug adapter is installed
			require("mason-nvim-dap").setup({
				ensure_installed = { "java-debug-adapter", "java-test", "codelldb" },
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			-- get access to the lspconfig plugins functions
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			-- setup the lua language server
			vim.lsp.config.lua_ls = {
				capabilities = capabilities,
			}

			vim.lsp.enable("lua_ls")

			local python_path = vim.fn.exepath("python")

			vim.lsp.config.pyright = {
				capabilities = capabilities,
				filetypes = { "python" },
				settings = {
					python = {
						pythonPath = python_path,
						analysis = {
							autoSearchPaths = true,
							useLibraryCodeForTypes = true,
							diagnosticMode = "workspace", -- было "openFilesOnly" — теперь полный проект
							typeCheckingMode = "basic", -- или "strict"
							reportMissingTypeStubs = false,
						},
					},
				},
			}

			vim.lsp.enable("pyright")

			vim.lsp.config.lemminx = {
				capabilities = capabilities,
				settings = {
					xml = {
						format = {
							enabled = true,
							splitAttributes = "preserve", -- не ломает длинные <dependency>
							maxLineWidth = 300,
						},
						server = {
							workDir = "~/.cache/lemminx", -- чтобы не засорять
						},
					},
				},
			}
			vim.lsp.enable("lemminx")

			vim.lsp.config.clangd = {
				capabilities = capabilities,
				cmd = {
					"clangd",
					"--background-index",
					"--clang-tidy",
					"--header-insertion=iwyu",
					"--completion-style=detailed",
					"--pch-storage=memory",
					"--j=4", -- количество потоков
				},
				init_options = {
					fallbackFlags = { "-std=c++23" }, -- можно менять на c++17/c++23
				},
				settings = {
					clangd = {
						inlayHints = {
							parameterNames = true,
							designatedParameters = true,
						},
					},
				},
			}
			vim.lsp.enable("clangd")
			-- Set vim motion for <Space> + c + h to show code documentation about the code the cursor is currently over if available
			vim.keymap.set("n", "<leader>ch", vim.lsp.buf.hover, { desc = "[C]ode [H]over Documentation" })
			-- Set vim motion for <Space> + c + d to go where the code/variable under the cursor was defined
			vim.keymap.set("n", "<leader>cd", vim.lsp.buf.definition, { desc = "[C]ode Goto [D]efinition" })
			-- Set vim motion for <Space> + c + a for display code action suggestions for code diagnostics in both normal and visual mode
			vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "[C]ode [A]ctions" })
			-- Set vim motion for <Space> + c + r to display references to the code under the cursor
			vim.keymap.set(
				"n",
				"<leader>cr",
				require("telescope.builtin").lsp_references,
				{ desc = "[C]ode Goto [R]eferences" }
			)
			-- Set vim motion for <Space> + c + i to display implementations to the code under the cursor
			vim.keymap.set(
				"n",
				"<leader>ci",
				require("telescope.builtin").lsp_implementations,
				{ desc = "[C]ode Goto [I]mplementations" }
			)
			-- Set a vim motion for <Space> + c + <Shift>R to smartly rename the code under the cursor
			vim.keymap.set("n", "<leader>cR", vim.lsp.buf.rename, { desc = "[C]ode [R]ename" })
			-- Set a vim motion for <Space> + c + <Shift>D to go to where the code/object was declared in the project (class file)
			vim.keymap.set("n", "<leader>cD", vim.lsp.buf.declaration, { desc = "[C]ode Goto [D]eclaration" })
			-- Лучше показывать диагностику
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
