return {
    { 
        'neovim/nvim-lspconfig',
        dependencies = {
            { 'hrsh7th/cmp-nvim-lsp' },
        },
    },
    {
        "williamboman/mason.nvim"
    },
    {
        'hrsh7th/nvim-cmp',
        dependencies = {
            -- { 'L3MON4D3/LuaSnip', build = "make install_jsregexp" },
            -- {
            --     'L3MON4D3/cmp-luasnip-choice',
            --     opts = {
            --         auto_open = true, -- Automatically open nvim-cmp on choice node (default: true)
            --     },
            -- },
        }
    }
}
