vim.opt.spell = true
vim.opt.spelllang = {'pl', 'en'}

vim.opt.conceallevel = 2
vim.opt.wrap = true

require("nvim-treesitter.configs").setup({
    ensure_installed = { "markdown", "markdown_inline"},
    highlight = {
        enable = true,
    },
})

