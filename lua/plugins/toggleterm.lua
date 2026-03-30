return {
	"akinsho/toggleterm.nvim",
	version = "*",
	config = function()
		require("toggleterm").setup({
			size = 15, -- высота горизонтальной консоли
			direction = "horizontal", -- всегда снизу
			open_mapping = "<leader>tt", -- <leader>tt = открыть/закрыть
			hide_numbers = true,
			shade_terminals = true,
			start_in_insert = true,
			persist_size = true,
			close_on_exit = true,
		})

		-- Дополнительно: отправлять выделенный код в терминал (удобно для тестов)
		vim.keymap.set("v", "<leader>ts", ":ToggleTermSendVisualSelection<CR>", { desc = "[T]erminal [S]end" })
	end,
}
