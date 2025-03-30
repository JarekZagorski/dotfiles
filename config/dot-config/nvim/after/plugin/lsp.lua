local capabilities = require('cmp_nvim_lsp').default_capabilities()

require('lspconfig').gopls.setup {
    capabilities = capabilities
}

require('lspconfig').lua_ls.setup {
    capabilities = capabilities,
    settings = {
        telemetry = { enable = false },
        workspace = { checkThirdParty = false },
    },
}
