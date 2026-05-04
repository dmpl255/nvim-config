return {
	{
		"rcarriga/neotest",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
			"antoinemadec/FixCursorHold.nvim",
		},
		config = function()
			require("neotest").setup({})
		end,
	},
	{
		"codeprefect/neotest-java",
		ft = { "java" },
		dependencies = {
			"rcarriga/neotest",
		},
		config = function()
			require("neotest").setup({
				adapters = {
					require("neotest-java"),
				},
			})
			vim.keymap.set("n", "<leader>tr", function()
				require("neotest").run.run()
			end, { desc = "[T]est [R]un Nearest" })
			vim.keymap.set("n", "<leader>tf", function()
				require("neotest").run.run(vim.fn.expand("%"))
			end, { desc = "[T]est [F]ile" })
			vim.keymap.set("n", "<leader>ts", function()
				require("neotest").summary.toggle()
			end, { desc = "[T]est [S]ummary" })
		end,
	},
}
