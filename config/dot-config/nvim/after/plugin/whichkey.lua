local telescope = require('telescope.builtin')
local wk = require("which-key")
local lib = require('custom.lib')

-- Telescope
--vim.keymap.set('n', '<leader>pf', telescope_b.find_files, {})
--vim.keymap.set('n', '<C-p>', telescope.git_files, {})
-- Neotree
--vim.keymap.set("n", "<leader>pv", vim.cmd.Neotree)
-- Undotree
vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle)
-- Fugitive
vim.keymap.set('n', '<leader>gs', vim.cmd.Git)
-- Harpoon
local mark = require('harpoon.mark')
local ui = require('harpoon.ui')


-- <leader> segment
wk.add({
    { "<leader>f",  group = "File", },
    { "<leader>ff", telescope.find_files,                 desc = "File List" },
    { "<leader>fg", telescope.live_grep,                  desc = "File Grep" },
    { "<leader>p",  group = "Project", },
    { "<leader>pv", "<cmd>Neotree position=current <cr>", desc = "View" },
    { "<leader>y",  'V"+y',                               desc = "Yank line to clipboard" },
})

-- Harpoon mappings
vim.keymap.set('n', '<leader>a', mark.add_file, { desc = 'Harpoon: add file' })
vim.keymap.set('n', '<C-e>', ui.toggle_quick_menu, { desc = 'Harpoon: open menu' })
vim.keymap.set('n', '<C-h>', function() ui.nav_file(1) end, { desc = 'Harpoon: file 1' })
vim.keymap.set('n', '<C-j>', function() ui.nav_file(2) end, { desc = 'Harpoon: file 2' })
vim.keymap.set('n', '<C-k>', function() ui.nav_file(3) end, { desc = 'Harpoon: file 3' })
vim.keymap.set('n', '<C-l>', function() ui.nav_file(4) end, { desc = 'Harpoon: file 4' })

-- lsp mappings
vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = 'Display Hover Information' })
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = 'Jump to definition' })
vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { desc = 'Jump to Declaration' })
vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { desc = 'List implementations' })
vim.keymap.set('n', 'go', vim.lsp.buf.type_definition, { desc = 'Jump to type definition' })
vim.keymap.set('n', 'gr', vim.lsp.buf.references, { desc = 'List all references' })
vim.keymap.set('n', 'gs', vim.lsp.buf.signature_help, { desc = 'Display signature information' })
vim.keymap.set('n', 'gl', vim.diagnostic.open_float, { desc = 'Show Diagnostics' })
vim.keymap.set('n', '<F2>', vim.lsp.buf.rename, { desc = 'Rename' })
vim.keymap.set('n', '<F3>', vim.lsp.buf.format, { desc = 'Format buffer using attached lsp' })
vim.keymap.set('n', '<F4>', vim.lsp.buf.code_action, { desc = 'Code action' })
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Previous diagnostics' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Next diagnostics' })
