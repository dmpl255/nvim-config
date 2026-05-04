return {
	"nvimtools/none-ls.nvim",
	dependencies = {
		"nvimtools/none-ls-extras.nvim",
	},
	config = function()
		local null_ls = require("null-ls")
		null_ls.setup({
			sources = {
				null_ls.builtins.formatting.stylua,
                null_ls.builtins.formatting.clang_format,
				null_ls.builtins.formatting.prettier,
				null_ls.builtins.diagnostics.mypy,
				require("none-ls.diagnostics.ruff"),
				null_ls.builtins.formatting.black,
			},
		})

		vim.keymap.set("n", "<leader>cf", vim.lsp.buf.format, { desc = "[C]ode [F]ormat" })
	end,
}
