-- Setup our JDTLS server any time we open up a java file
-- Setup JDTLS + Treesitter для Java
vim.api.nvim_create_augroup("jdtls_lsp", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
    group = "jdtls_lsp",
    pattern = "java",
    callback = function()
        require("config.jdtls").setup_jdtls()
    end,
})

