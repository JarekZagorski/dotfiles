vim.lsp.config('*', {
  -- this one adds clients capabilities
  capabilities = require('cmp_nvim_lsp').default_capabilities()
})

vim.lsp.enable {
  'lua_ls',
  'zls',
  'gopls',
}
