return {
  {
    'neovim/nvim-lspconfig',
    dependencies = { 'hrsh7th/cmp-nvim-lsp' },
  },
  { "williamboman/mason.nvim" },
  { 'hrsh7th/nvim-cmp' },
  {
    "L3MON4D3/LuaSnip",
    -- follow latest release.
    version = "v2.*",
    -- install jsregexp (optional!).
    build = "make install_jsregexp",
    dependencies = { 'saadparwaiz1/cmp_luasnip' },
  },
}
