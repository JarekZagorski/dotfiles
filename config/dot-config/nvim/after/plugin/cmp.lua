local cmp = require 'cmp'
local luasnip = require 'luasnip'

local completion_mapping = {
  ['<CR>'] = cmp.mapping(function(fallback)
    if cmp.visible() then
      if luasnip.expandable() then
        luasnip.expand {}
      else
        cmp.confirm { select = true }
      end
    else
      fallback()
    end
  end),

  ['<Tab>'] = cmp.mapping(function(fallback)
    if cmp.visible() then
      cmp.select_next_item()
    elseif luasnip.locally_jumpable(1) then
      luasnip.jump(1)
    else
      fallback()
    end
  end, { 'i', 's' }),

  ['<S-Tab>'] = cmp.mapping(function(fallback)
    if cmp.visible() then
      cmp.select_prev_item()
    elseif luasnip.locally_jumpable(-1) then
      luasnip.jump(-1)
    else
      fallback()
    end
  end, { 'i', 's' }),
  -- ... Your other mappings ...
  ['<C-b>'] = cmp.mapping.scroll_docs(-4),
  ['<C-f>'] = cmp.mapping.scroll_docs(4),
  ['<C-Space>'] = cmp.mapping.complete(),
  -- ['<C-e>'] = cmp.mapping.abort(),
}

cmp.setup({
  snippet = {
    expand = function(args)
      -- vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)
      luasnip.lsp_expand(args.body)
    end,
  },
  window = {
    -- completion = cmp.config.window.bordered(),
    -- documentation = cmp.config.window.bordered(),
  },
  -- mapping = cmp.mapping.preset.insert({ -- if defaults are indeed wanted
  mapping = completion_mapping,
  sources = cmp.config.sources {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'buffer' },
  },
  -- preselect = 'None',
})

-- To use git you need to install the plugin petertriho/cmp-git and uncomment lines below
-- Set configuration for specific filetype.
--[[ cmp.setup.filetype('gitcommit', {
sources = cmp.config.sources({
  { name = 'git' },
}, {
  { name = 'buffer' },
})
})
require("cmp_git").setup() ]] --

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
-- cmp.setup.cmdline({ '/', '?' }, {
-- mapping = cmp.mapping.preset.cmdline(),
-- sources = {
--   { name = 'buffer' }
-- }
-- })

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
-- cmp.setup.cmdline(':', {
--     mapping = completion_mapping,
--     sources = cmp.config.sources({
--       { name = 'path' }
--     }, {
--       { name = 'cmdline' }
--     }),
--     matching = { disallow_symbol_nonprefix_matching = false },
-- })
