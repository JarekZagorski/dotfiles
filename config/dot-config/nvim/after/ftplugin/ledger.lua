local cmp = require 'cmp'

cmp.setup.buffer {
  sources = vim.tbl_extend('keep', {
    { name = 'ledger' }
  }, cmp.get_config().sources)
}
