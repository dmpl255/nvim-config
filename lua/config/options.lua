vim.opt.number = true         -- Отображает номер строк
vim.opt.relativenumber = true -- Отображает относительный номер строки
vim.opt.numberwidth = 2       -- Ширина колонки слева
vim.opt.signcolumn = "yes"    -- always show sign column
vim.opt.wrap = true           -- Включает автоматический перенос строк
vim.opt.scrolloff = 10        -- Число строк, которые будут показаны относительно курсора сверху и снизу
vim.opt.sidescrolloff = 8     -- Аналогично слева и справа до конца окна

-- Tab spacing/behavior
vim.opt.expandtab = true   -- convert tabs to spaces
vim.opt.shiftwidth = 4     -- number of spaces inserted for each indentation level
vim.opt.tabstop = 4        -- number of spaces inserted for tab character
vim.opt.softtabstop = 4    -- number of spaces inserted for <Tab> key
vim.opt.smartindent = true -- Включает умные отступы
vim.opt.breakindent = true -- Включает визуально аккуратные строки

-- General Behaviors
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.backup = false            -- disable backup file creation
vim.opt.clipboard = "unnamedplus" -- enable system clipboard access
vim.opt.conceallevel = 0          -- so that `` is visible in markdown files
vim.opt.fileencoding = "utf-8"    -- set file encoding to UTF-8
vim.opt.mouse = "a"               -- enable mouse support
vim.opt.showmode = false          -- hide mode display
vim.opt.splitbelow = true         -- force horizontal splits below current window
vim.opt.splitright = true         -- force vertical splits right of current window
vim.opt.termguicolors = true      -- enable term GUI colors
vim.opt.timeoutlen = 1000         -- set timeout for mapped sequences
vim.opt.undofile = true           -- enable persistent undo
vim.opt.updatetime = 100          -- set faster completion
vim.opt.writebackup = false       -- prevent editing of files being edited elsewhere
vim.opt.cursorline = true         -- highlight current line

-- Searching Behaviors
vim.opt.hlsearch = true   -- highlight all matches in search
vim.opt.ignorecase = true -- ignore case in search
vim.opt.smartcase = true  -- match case if explicitly stated
