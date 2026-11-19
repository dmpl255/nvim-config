return {
	"rachartier/tiny-cmdline.nvim",
	init = function()
		vim.o.cmdheight = 0
	end,
	opts = {
		position = {
			x = "50%",
			y = "10%",
		},
	},
}
