-- this is here to set some default options

-- set tabs instead of spaces and tab = 4 spaces
-- see ':help tabstop'
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- enable line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- disable line wrap
vim.opt.wrap = false

-- number of lines that should be above / below cursor
vim.opt.scrolloff = 12

-- enable signcolumn for some additional info
vim.opt.signcolumn = 'yes:1'

-- save swap file more often
vim.opt.updatetime = 1000

-- some better stuff for default completion window
vim.cmd[[set completeopt+=menuone,noselect,popup]]
