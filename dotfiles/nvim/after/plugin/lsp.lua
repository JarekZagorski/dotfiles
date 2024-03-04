local lsp = require('lsp-zero')

lsp.on_attach(function(client, bufnr)
    -- see :help lsp-zero-keybindings
    -- to learn the available actions
    lsp.default_keymaps({ buffer = bufnr })
end)

require('mason').setup({})
require('mason-lspconfig').setup({
    ensure_installed = {
        'clangd',
        'gopls',
        'pyright',
        'rust_analyzer',
        'tsserver',
        'robotframework_ls',
        'bashls',
        'nil_ls',
        'lua_ls',
        'marksman',
    },

    handlers = {
        lsp.default_setup,
        ---[[
        lua_ls = function() 
             require('lspconfig').lua_ls.setup({
                workspace = { 
                    checkThirdParty = false,
                },
                telemetry = { enable = false },
                library = {
                    vim.env.VIMRUNTIME,
                    -- "${3rd}/luv/library"
                    -- "${3rd}/busted/library",
                }
                -- or pull in all of 'runtimepath'. NOTE: this is a lot slower
                -- library = vim.api.nvim_get_runtime_file("", true)
            })
        end
        --]]
    },
})
