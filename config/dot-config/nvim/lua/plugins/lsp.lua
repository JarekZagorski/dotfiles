return {
    {
        "folke/lazydev.nvim",
        ft = "lua", -- only load on lua files
        opts = {
            library = {
                -- See the configuration section for more details
                -- Load luvit types when the `vim.uv` word is found
                { path = "luvit-meta/library", words = { "vim%.uv" } },
                -- Only load the lazyvim library when the `LazyVim` global is found
                { path = "LazyVim",            words = { "LazyVim" } },
            },
        },
    },
    { "Bilal2453/luvit-meta",             lazy = true }, -- optional `vim.uv` typings
    -- { "folke/neodev.nvim", enabled = false }, -- make sure to uninstall or disable neodev.nvim

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
        opts = function(_, opts)
            opts.sources = opts.sources or {}
            table.insert(opts.sources, {
                name = "lazydev",
                group_index = 0, -- set group index to 0 to skip loading LuaLS completions
            })
        end,
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
