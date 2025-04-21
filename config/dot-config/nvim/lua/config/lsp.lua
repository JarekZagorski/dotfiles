vim.lsp.config('*', {
  -- this one adds clients capabilities
  capabilities = require('cmp_nvim_lsp').default_capabilities()
})

local enabled_servers = {
  'lua_ls',
  'zls',
  'gopls',
}

-- provide each server with some default config, else it fails
-- it's for every server that has no special settings
for _, server in ipairs(enabled_servers) do
  vim.lsp.config(server, {})
end

vim.lsp.enable(enabled_servers)
