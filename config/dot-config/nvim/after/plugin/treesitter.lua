---@diagnostic disable-next-line: missing-fields
require 'nvim-treesitter.configs'.setup {
  ensure_installed = {
    "comment",
    "lua",
  },

  auto_install = true,

  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
}
