vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Remove search highlights" })

vim.keymap.set("n", "<C-Left>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-Right>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-Down>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-Up>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

vim.keymap.set("n", "<leader>wv", ":vsplit<cr>", { desc = "[W]indow Split [V]ertical" })
vim.keymap.set("n", "<leader>wh", ":split<cr>", { desc = "[W]indow Split [H]orizontal" })

vim.keymap.set("v", "<", "<gv", { desc = "Indent left in visual mode" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent right in visual mode" })

local startup_dir = vim.fn.getcwd()

local function open_external_terminal(dir)
    local escaped_dir = dir:gsub(" ", "\\ ")
    local cmd = string.format("alacritty --working-directory %s", escaped_dir)
    vim.fn.jobstart(cmd, { detach = true })
end

vim.keymap.set("n", "<leader>tt", function()
    open_external_terminal(startup_dir)
end, { desc = "Open alacritty in startup directory" })

vim.keymap.set("n", "<leader>tf", function()
    local file = vim.fn.expand("%:p")
    local dir
    if file ~= "" then
        dir = vim.fn.fnamemodify(file, ":h")
    else
        dir = startup_dir
    end
    open_external_terminal(dir)
end, { desc = "Open alacritty in file's directory" })
