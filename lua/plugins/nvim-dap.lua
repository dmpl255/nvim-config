return {
	{
		"mfussenegger/nvim-dap",

		keys = {
			{
				"<leader>db",
				function()
					require("dap").toggle_breakpoint()
				end,
				desc = "[D]ebug [B]reakpoint",
			},

			{
				"<leader>ds",
				function()
					local dap = require("dap")

					-- Java-specific DAP initialization.
					if vim.bo.filetype == "java" then
						local jdtls = require("jdtls")

						jdtls.setup_dap({
							hotcodereplace = "auto",
						})

						require("jdtls.dap").setup_dap_main_class_configs({
							on_ready = function()
								dap.continue()
							end,
						})

						return
					end

					dap.continue()
				end,
				desc = "[D]ebug [S]tart / Continue",
			},

			{
				"<leader>dr",
				function()
					require("dapui").float_element("repl", {
						enter = true,
						width = math.floor(vim.o.columns * 0.8),
						height = math.floor(vim.o.lines * 0.7),
						position = "center",
					})
				end,
				desc = "[D]ebug [R]EPL",
			},

			{
				"<leader>do",
				function()
					require("dapui").float_element("scopes", {
						enter = true,
						width = math.floor(vim.o.columns * 0.8),
						height = math.floor(vim.o.lines * 0.7),
						position = "center",
					})
				end,
				desc = "[D]ebug [O]utput / Scopes",
			},

			{
				"<leader>dB",
				function()
					require("dapui").float_element("breakpoints", {
						enter = true,
						width = math.floor(vim.o.columns * 0.8),
						height = math.floor(vim.o.lines * 0.7),
						position = "center",
					})
				end,
				desc = "[D]ebug [B]reakpoints",
			},

			{
				"<leader>dS",
				function()
					require("dapui").float_element("stacks", {
						enter = true,
						width = math.floor(vim.o.columns * 0.8),
						height = math.floor(vim.o.lines * 0.7),
						position = "center",
					})
				end,
				desc = "[D]ebug [S]tack",
			},

			{
				"<leader>dw",
				function()
					require("dapui").float_element("watches", {
						enter = true,
						width = math.floor(vim.o.columns * 0.8),
						height = math.floor(vim.o.lines * 0.7),
						position = "center",
					})
				end,
				desc = "[D]ebug [W]atches",
			},

			{
				"<leader>dC",
				function()
					require("dapui").float_element("console", {
						enter = true,
						width = math.floor(vim.o.columns * 0.8),
						height = math.floor(vim.o.lines * 0.7),
						position = "center",
					})
				end,
				desc = "[D]ebug [C]onsole",
			},

			{
				"<leader>dc",
				function()
					require("dapui").close()
				end,
				desc = "[D]ebug [C]lose",
			},
		},

		dependencies = {
			{
				"rcarriga/nvim-dap-ui",
				dependencies = {
					"nvim-neotest/nvim-nio",
				},
			},

			{
				"mfussenegger/nvim-dap-python",
				config = function()
					local debugpy_python =
						vim.fn.stdpath("data")
						.. "/mason/packages/debugpy/venv/bin/python"

					require("dap-python").setup(debugpy_python)
				end,
			},

			{
				"theHamsta/nvim-dap-virtual-text",
				dependencies = {
					"nvim-treesitter/nvim-treesitter",
				},
				opts = {},
			},
		},

		config = function()
			local dap = require("dap")
			local dapui = require("dapui")

			dapui.setup({
				controls = {
					enabled = true,
					element = "repl",

					icons = {
						pause = "⏸",
						play = "▶",
						step_into = "↓",
						step_over = "↷",
						step_out = "↑",
						step_back = "↶",
						run_last = "↻",
						terminate = "■",
					},
				},

				floating = {
					border = "rounded",
					max_width = 0.9,
					max_height = 0.9,

					mappings = {
						close = {
							"q",
							"<Esc>",
						},
					},
				},
			})

			-- Don't automatically open the regular dap-ui layouts.
			-- We use floating elements instead.

			dap.listeners.after.event_terminated.dapui_config = function()
				dapui.close()
			end

			dap.listeners.after.event_exited.dapui_config = function()
				dapui.close()
			end

			-- Java DAP configuration.
			dap.configurations.java = {
				{
					type = "java",
					request = "attach",
					name = "Attach to Tomcat (Port 8000)",
					hostName = "127.0.0.1",
					port = 8000,
				},
			}
		end,
	},
}
