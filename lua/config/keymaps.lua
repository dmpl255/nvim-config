vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Remove search highlights" })

vim.keymap.set("n", "<C-Left>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-Right>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-Down>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-Up>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

vim.keymap.set("n", "<leader>wv", ":vsplit<cr>", { desc = "[W]indow Split [V]ertical" })
vim.keymap.set("n", "<leader>wh", ":split<cr>", { desc = "[W]indow Split [H]orizontal" })

vim.keymap.set("v", "<", "<gv", { desc = "Indent left in visual mode" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent right in visual mode" })

vim.keymap.set("n", "<C-a>", "gg<S-v>G", { desc = "Copy all" })
vim.keymap.set("n", "+", "<C-a>", { desc = "Increment number" })
vim.keymap.set("n", "-", "<C-x>", { desc = "Decrement number" })

-- =========================================
-- Terminal
-- =========================================

local function toggle_terminal(cwd)
	local terminal = vim.b.snacks_terminal

	if type(terminal) == "table" and terminal.cwd then
		cwd = terminal.cwd
	end

	Snacks.terminal.toggle(nil, {
		cwd = cwd or vim.fn.getcwd(),
	})
end

vim.keymap.set({ "n", "t" }, "<leader>tt", function()
	toggle_terminal()
end, {
	desc = "[T]oggle [T]erminal",
})

vim.keymap.set("n", "<leader>tf", function()
	local file = vim.api.nvim_buf_get_name(0)

	local dir = file ~= "" and vim.fn.fnamemodify(file, ":p:h") or vim.fn.getcwd()

	toggle_terminal(dir)
end, {
	desc = "[T]erminal [F]ile directory",
})

-- =========================================
-- Comment
-- =========================================

vim.keymap.set("n", "<leader>/", "gcc", {
	remap = true,
	desc = "Comment line",
})

vim.keymap.set("v", "<leader>/", "gc", {
	remap = true,
	desc = "Comment selection",
})
