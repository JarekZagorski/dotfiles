-- Telescope
local telescope = require('telescope.builtin')
--vim.keymap.set('n', '<C-p>', telescope.git_files, {})
-- Fugitive
vim.keymap.set('n', '<leader>gs', vim.cmd.Git, { desc = 'Git Fugitive: git status' })
-- vim.keymap.set('n', '<leader>gc', vim.cmd.Git, { desc = 'Git Fugitive: git status' })
-- <leader> segment
vim.keymap.set('n', '<leader>ff', telescope.find_files, { desc = 'Find File' })
vim.keymap.set('n', '<leader>fg', telescope.live_grep, { desc = 'File Grep' })
vim.keymap.set('n', '<leader>pv', '<cmd>Yazi toggle<cr>', { desc = 'Project View' })
vim.keymap.set('v', '<leader>y', '"+y', { desc = 'Yank line to clipboard' })

-- lsp keymaps
vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = 'Display Hover Information' })
vim.keymap.set('n', 'gdd', vim.lsp.buf.definition, { desc = 'Jump to definition' })
vim.keymap.set('n', 'go', vim.lsp.buf.type_definition, { desc = 'Jump to type definition' })
vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { desc = 'Jump to Declaration' })
vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { desc = 'List implementations' })
vim.keymap.set('n', 'gr', vim.lsp.buf.references, { desc = 'List all references' })
vim.keymap.set('n', 'gs', vim.lsp.buf.signature_help, { desc = 'Display signature information' })
vim.keymap.set('n', 'gl', vim.diagnostic.open_float, { desc = 'Show Diagnostics' })
vim.keymap.set('n', '<F2>', vim.lsp.buf.rename, { desc = 'Rename' })
vim.keymap.set('n', '<F3>', vim.lsp.buf.format, { desc = 'Format buffer using attached lsp' })
vim.keymap.set('n', '<F4>', vim.lsp.buf.code_action, { desc = 'Code action' })
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Previous diagnostics' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Next diagnostics' })
