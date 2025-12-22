vim.lsp.config('*', {
  -- this one adds clients capabilities
  capabilities = require('cmp_nvim_lsp').default_capabilities(),
  ---@type vim.lsp.client.on_attach_cb
  on_attach = function(client, bufnr)
    if client.server_capabilities.documentFormattingProvider then
      vim.api.nvim_create_autocmd('BufWritePre', {
        group = vim.api.nvim_create_augroup('Format', { clear = true }),
        buffer = bufnr,
        callback = function() vim.lsp.buf.format({ bufnr = bufnr }) end,
      })
    end
  end
})

local enabled_servers = {
  'lua_ls',
  'zls',
  'gopls',
  'cssls',
  'nushell',
  'ocamllsp',
  'csharp_ls',
  'ts_ls',
  'fsautocomplete',
  'pyright',
}

-- provide each server with some default config, else it fails
-- it's for every server that has no special settings
for _, server in ipairs(enabled_servers) do
  vim.lsp.config(server, {})
end

vim.lsp.enable(enabled_servers)
