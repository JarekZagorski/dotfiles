-- in there shall be plugins concerning looks and feels of nvim
return {
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' }
    },
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        opts = {},
    },
    {
        'edkolev/tmuxline.vim',
        lazy = false,
        priority = 1000,
    },
    {
        "f-person/auto-dark-mode.nvim",
    }
}
