return {
	"akinsho/toggleterm.nvim",
	version = "*",
	config = function()
		require("toggleterm").setup({
			size = 15,
			direction = "horizontal",
			open_mapping = "<leader>tt",
			hide_numbers = true,
			shade_terminals = true,
			start_in_insert = true,
			persist_size = true,
			close_on_exit = true,
		})

		vim.keymap.set("v", "<leader>ts", ":ToggleTermSendVisualSelection<CR>", { desc = "[T]erminal [S]end" })
	end,
}
