return {
	"G00380316/live-server.nvim",

	cmd = "LiveServer",

	keys = {
		{
			"<leader>ls",
			"<Cmd>LiveServer toggle<CR>",
			desc = "Toggle live server",
		},
		{
			"<leader>lm",
			"<Cmd>LiveServer<CR>",
			desc = "Live server manager",
		},
		{
			"<leader>lo",
			"<Cmd>LiveServer open<CR>",
			desc = "Open in browser",
		},
		{
			"<leader>ll",
			"<Cmd>LiveServer logs<CR>",
			desc = "Live server logs",
		},
	},

	opts = {
		server = "live_server",

		host = "127.0.0.1",

		browser = {
			auto_open = true,
			open_current_file = true,
		},

		port = {
			strategy = "pin",
		},
	},
}
