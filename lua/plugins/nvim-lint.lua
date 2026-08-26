local linters_by_ft = {
	python = { "ruff" },
}

return {
	{
		"mfussenegger/nvim-lint",

		ft = vim.tbl_keys(linters_by_ft),

		opts = {
			linters_by_ft = linters_by_ft,
		},

		config = function(_, opts)
			local lint = require("lint")

			lint.linters_by_ft = opts.linters_by_ft

			vim.api.nvim_create_autocmd({ "BufReadPost", "BufWritePost" }, {
				callback = function()
					lint.try_lint()
				end,
			})
		end,
	},
}
