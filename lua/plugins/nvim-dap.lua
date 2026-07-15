return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"nvim-neotest/nvim-nio",
		},
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")

			dapui.setup()

			dap.listeners.before.launch.dapui_config = function()
				dapui.open()
			end

			dap.listeners.before.event_terminated.dapui_config = function()
				dapui.close()
			end
			dap.listeners.before.event_exited.dapui_config = function()
				dapui.close()
			end

			vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "[D]ebug [T]oggle Breakpoint" })
			vim.keymap.set("n", "<leader>ds", dap.continue, { desc = "[D]ebug [S]tart" })

			vim.keymap.set("n", "<leader>dc", dapui.close, { desc = "[D]ebug [C]lose" })

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
	{
		"mfussenegger/nvim-dap-python",
		ft = { "python" },
		dependencies = {
			"mfussenegger/nvim-dap",
		},
		config = function(_, opts)
			local path = vim.fn.stdpath("data") .. "/mason/packages/debugpy/venv/bin/python"
			require("dap-python").setup(path)
		end,
	},
	{
		"theHamsta/nvim-dap-virtual-text",
		dependencies = { "mfussenegger/nvim-dap", "nvim-treesitter/nvim-treesitter" },
		config = function()
			require("nvim-dap-virtual-text").setup()
		end,
	},
}
