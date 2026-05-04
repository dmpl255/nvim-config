return {
	"folke/which-key.nvim",
	event = "VimEnter",
	config = function()
		local which_key = require("which-key")

		which_key.setup()

		which_key.add({
			{ "<leader>/", group = "Comments" },
			{ "<leader>J", group = "[J]ava" },
			{ "<leader>c", group = "[C]ode" },
			{ "<leader>d", group = "[D]ebug" },
			{ "<leader>e", group = "[E]xplorer" },
			{ "<leader>f", group = "[F]ind" },
			{ "<leader>g", group = "[g]it" },
			{ "<leader>w", group = "[W]indow" },
			{ "<leader>G", group = "[G]radle" },
			{ "<leader>M", group = "[M]aven" },
			{ "<leader>t", group = "[T]erminal" },
			{ "<leader>Js", group = "[S]pring" },
			{ "<leader>cg", group = "[C]make [G]enerate" },
			{ "<leader>cm", group = "[Cm]ake" },
		})
	end,
}
