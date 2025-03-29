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
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
    },
}
