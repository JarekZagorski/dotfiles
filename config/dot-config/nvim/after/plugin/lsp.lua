local capabilities = require('cmp_nvim_lsp').default_capabilities()

vim.lsp.config('*', {
    capabilities = capabilities
})

require('lspconfig').gopls.setup {}

require('lspconfig').lua_ls.setup {
    settings = {
        telemetry = { enable = false },
        workspace = { checkThirdParty = false },
    },
}

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

require('lspconfig').templ.setup {
    on_attach = function(client, bufnr)
        vim.keymap.set('n', '<F3>', templ_format, { buffer = bufnr, remap = false })
    end,
    cmd = { 'templ', 'lsp' },
    cmd_env = { TEMPL_EXPERIMENT = 'rawgo', TEST = "false" }
}

require 'lspconfig'.htmx.setup({
    filetypes = { 'templ' }
})
