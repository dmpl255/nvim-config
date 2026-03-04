return {
	-- Shortened Github Url
	"folke/tokyonight.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		-- Make sure to set the color scheme when neovim loads and configures the tokyonight plugin
		vim.cmd.colorscheme("tokyonight")
	end,
}
