---@type LazySpec
return {
    { "folke/neodev.nvim",                opts = {} },
    { 'VonHeikemen/lsp-zero.nvim',        branch = 'v3.x' },

    { 'williamboman/mason.nvim' },
    { 'williamboman/mason-lspconfig.nvim' },

    -- LSP Support
    {
        'neovim/nvim-lspconfig',
        dependencies = {
            { 'hrsh7th/cmp-nvim-lsp' },
        },
    },

    -- Autocompletion
    {
        'hrsh7th/nvim-cmp',
        dependencies = {
            { 'L3MON4D3/LuaSnip', build = "make install_jsregexp" },
            {
                'L3MON4D3/cmp-luasnip-choice',
                config = function()
                    require('cmp_luasnip_choice').setup({
                        auto_open = true, -- Automatically open nvim-cmp on choice node (default: true)
                    })
                end
            },
        }
    }
}
