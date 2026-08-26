local languages = {
	"vim",
	"vimdoc",
	"lua",
	"java",
	"javadoc",
	"python",
	"c",
	"cpp",
	"cuda",
	"cmake",
	"xml",
	"yaml",
	"json",
	"markdown",
	"markdown_inline",
	"gitignore",
	"html",
}

return {
	{
		"nvim-treesitter/nvim-treesitter",
		lazy = false,
		build = ":TSUpdate",

		config = function()
			local ts = require("nvim-treesitter")

			ts.install(languages)

			vim.api.nvim_create_autocmd("FileType", {
				pattern = languages,
				callback = function()
					vim.treesitter.start()

					vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
					vim.wo.foldmethod = "expr"
					vim.wo.foldlevel = 99

					vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
				end,
			})
		end,
	},
}
