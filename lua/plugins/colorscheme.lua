return {
	-- Default colorscheme
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			vim.opt.termguicolors = true
			vim.o.background = "dark"
			vim.cmd.colorscheme("tokyonight")
		end,
	},
	{
		"projekt0n/github-nvim-theme",
		name = "github-theme",
		lazy = true,
	},
}

-- return {
--     -- GitHub theme (основная, светлая)
--     {
--         "projekt0n/github-nvim-theme",
--         name = "github-theme",
--         lazy = false,     -- Загружать при старте
--         priority = 1000,  -- Высокий приоритет, чтобы загрузиться раньше других
--         config = function()
--             vim.opt.termguicolors = true
--             -- Явно указываем, что фон светлый (полезно для некоторых плагинов)
--             vim.o.background = "light"
--             -- Устанавливаем светлую тему GitHub
--             vim.cmd.colorscheme("github_light")
--         end,
--     },
--
--     -- TokyoNight (оставляем, но делаем не основным)
--     -- Теперь он не будет загружаться при старте и не перебьет тему GitHub
--     {
--         "folke/tokyonight.nvim",
--         lazy = true,
--     },
-- }
