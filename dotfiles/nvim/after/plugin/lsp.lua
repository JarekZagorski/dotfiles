local lsp = require('lsp-zero')

lsp.on_attach(function(client, bufnr)
    -- see :help lsp-zero-keybindings
    -- to learn the available actions
    lsp.default_keymaps({ buffer = bufnr })
end)

local servers = {
    lua_ls = {
    },
}

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
        'marksman',
        'nil_ls',
    },
    handlers = {
        lsp.default_setup,
        lua_ls = function() 
             require('lspconfig').example_server.setup({
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
    },
})
