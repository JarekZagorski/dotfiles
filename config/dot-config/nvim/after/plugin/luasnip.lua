local luasnip = require 'luasnip'
luasnip.setup {}

require('luasnip.loaders.from_lua').load {
  paths = { vim.fn.stdpath'config' .. '/snippets' },
}
