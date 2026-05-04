return {
	"Civitasv/cmake-tools.nvim",
	ft = { "c", "cpp", "cuda", "cmake" },
	dependencies = { "nvim-lua/plenary.nvim" },
	opts = {
		cmake_command = "cmake",
		cmake_generate_options = { "-DCMAKE_EXPORT_COMPILE_COMMANDS=1" },
		cmake_build_options = {},
		cmake_regenerate_on_save = true,
		cmake_build_directory = "build",
		cmake_soft_stop = true,
	},
	config = function(_, opts)
		require("cmake-tools").setup(opts)

		vim.keymap.set("n", "<leader>cg", ":CMakeGenerate<CR>", { desc = "[C]make [G]enerate" })
		vim.keymap.set("n", "<leader>cb", ":CMakeBuild<CR>", { desc = "[C]make [B]uild" })
		vim.keymap.set("n", "<leader>cr", ":CMakeRun<CR>", { desc = "[C]make [R]un" })
		vim.keymap.set("n", "<leader>cdb", ":CMakeDebug<CR>", { desc = "[C]make [D]e[b]ug" })
		vim.keymap.set("n", "<leader>ct", ":CMakeTest<CR>", { desc = "[C]make [T]est" })
	end,
}
