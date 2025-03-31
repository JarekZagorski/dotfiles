return {
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.8',  -- may remove this
        dependencies = { 'nvim-lua/plenary.nvim' }
    },
    {
        'tpope/vim-fugitive',
    },
    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
    },
    {
        'folke/lazydev.nvim',
        ft = 'lua', -- only load on lua files
        opts = {
            library = {
                -- See the configuration section for more details
                -- Load luvit types when the `vim.uv` word is found
                { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
            },
            enabled = true,
        },
    },
    {
        'windwp/nvim-autopairs',
        event = 'InsertEnter',
        config = true,
        opts = {},
    },
    {
        'ThePrimeagen/harpoon',
        branch = 'harpoon2',
        dependencies = { 'nvim-lua/plenary.nvim' },
    },
}
