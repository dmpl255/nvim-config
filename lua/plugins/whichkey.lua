return {
	"folke/which-key.nvim",
	event = "VimEnter",
	config = function()
		-- gain access to the which key plugin
		local which_key = require("which-key")

		-- call the setup function with default properties
		which_key.setup()

		-- Register prefixes for the different key mappings we have setup previously
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
			{ "<leader>cg", group = "[C]make [G]enerate" }, -- или просто в +CMake
			{ "<leader>cm", group = "[Cm]ake" },
		})
	end,
}
