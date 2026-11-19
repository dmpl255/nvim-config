return {
	{
		"L3MON4D3/LuaSnip",
		lazy = true,
		version = "v2.*",
		build = "make install_jsregexp",
		dependencies = {
			{
				"rafamadriz/friendly-snippets",
				config = function()
					require("luasnip.loaders.from_vscode").lazy_load()
					require("luasnip.loaders.from_lua").lazy_load({
						paths = { vim.fn.stdpath("config") .. "/lua/snippets" },
					})
				end,
			},
		},
		opts = {
			keep_roots = true,
			link_roots = true,
			link_children = true,
			exit_roots = false,
			delete_check_events = "TextChanged",
		},
	},
	{
		"saghen/blink.cmp",
		event = "InsertEnter",

		dependencies = {
			"saghen/blink.lib",
			"rafamadriz/friendly-snippets",
		},
		build = function()
			require("blink.cmp").build():pwait()
		end,
		opts = {
			keymap = {
				preset = "none",

				["<Up>"] = { "select_prev", "fallback" },
				["<Down>"] = { "select_next", "fallback" },
				["<CR>"] = { "accept", "fallback" },

				["<Tab>"] = { "snippet_forward", "fallback" },
				["<S-Tab>"] = { "snippet_backward", "fallback" },

				["<C-Space>"] = {
					"show",
					"show_documentation",
					"hide_documentation",
				},
			},

			completion = {
				list = {
					selection = {
						preselect = false,
						auto_insert = false,
					},
				},
				documentation = {
					auto_show = true,
					auto_show_delay_ms = 200,
					window = {
						scrollbar = false,
					},
				},
				menu = {
					scrollbar = false,
				},
			},
			snippets = {
				preset = "luasnip",
			},

			sources = {
				default = {
					"lsp",
					"snippets",
					"buffer",
					"path",
				},
			},
			fuzzy = { implementation = "rust" },
		},
	},
}
