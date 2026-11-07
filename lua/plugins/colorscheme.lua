
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
        "catppuccin/nvim",
        name = "catppuccin",
        lazy = true,
    },
    {
        "rose-pine/neovim",
        name = "rose-pine",
        lazy = true,
    },
    {
        "rebelot/kanagawa.nvim",
        name = "kanagawa",
        lazy = true,
    },
    {
        "projekt0n/github-nvim-theme",
        name = "github-theme",
        lazy = true,
    },
    {
        "EdenEast/nightfox.nvim",
        name = "nightfox",
        lazy = true,
    },
    {
        "miikanissi/modus-themes.nvim",
        name = "modus",
        lazy = true,
    },
}

