local lsp = require('lsp-zero')

local function on_attach(client, bufnr)
    -- see :help lsp-zero-keybindings
    -- to learn the available actions
    lsp.default_keymaps({ buffer = bufnr })
end

lsp.on_attach(on_attach)

local templ_format = function()
    local bufnr = vim.api.nvim_get_current_buf()
    local filename = vim.api.nvim_buf_get_name(bufnr)
    local cmd = 'TEMPL_EXPERIMENT=rawgo templ fmt ' .. vim.fn.shellescape(filename)

    vim.fn.jobstart(cmd, {
        on_exit = function()
            -- Reload the buffer only if it's still the current buffer
            if vim.api.nvim_get_current_buf() == bufnr then
                vim.cmd('e!')
            end
        end,
    })
end

require('mason').setup({})
require('mason-lspconfig').setup({
    ensure_installed = {
        'clangd',
        'gopls',
        'pyright',
        'tsserver',
        'robotframework_ls',
        'bashls',
        'lua_ls',
        'marksman',
        'templ',
        'html',
        'htmx',
        'cssls',
    },

    handlers = {
        lsp.default_setup,
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
        end,
        templ = function()
            require 'lspconfig'.templ.setup({
                on_attach = function(client, bufnr)
                    vim.keymap.set('n', '<F3>', templ_format, { buffer = bufnr, remap = false })
                    on_attach(client, bufnr)
                end,
                cmd = { 'templ', 'lsp' },
                cmd_env = { TEMPL_EXPERIMENT = 'rawgo', TEST = "false" }
            })
        end,
        htmx = function()
            require 'lspconfig'.htmx.setup({
                on_attach = on_attach,
                filetypes = { 'templ' }
            })
        end,
    },
})
