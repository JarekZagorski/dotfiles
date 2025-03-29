
local telescope = require('telescope.builtin')
local set = vim.keymap.set

-- Telescope
--set('n', '<C-p>', telescope.git_files, {})
-- Fugitive
set('n', '<leader>gs', vim.cmd.Git, { desc = 'Git Fugitive: git status' })
-- set('n', '<leader>gc', vim.cmd.Git, { desc = 'Git Fugitive: git status' })
-- <leader> segment
set('n', '<leader>ff', telescope.find_files, { desc = 'Find File' })
set('n', '<leader>fg', telescope.live_grep, { desc = 'File Grep' })
set('n', '<leader>pv', '<cmd>Neotree position=current <cr>', { desc = 'Project View' })
set('n', '<leader>y', 'V"+y', { desc = 'Yank line to clipboard' })

--[ lsp descriptions
set('n', 'K', vim.lsp.buf.hover, { desc = 'Display Hover Information' })
set('n', 'gd', vim.lsp.buf.definition, { desc = 'Jump to definition' })
set('n', 'gD', vim.lsp.buf.declaration, { desc = 'Jump to Declaration' })
set('n', 'gi', vim.lsp.buf.implementation, { desc = 'List implementations' })
set('n', 'go', vim.lsp.buf.type_definition, { desc = 'Jump to type definition' })
set('n', 'gr', vim.lsp.buf.references, { desc = 'List all references' })
set('n', 'gs', vim.lsp.buf.signature_help, { desc = 'Display signature information' })
set('n', 'gl', vim.diagnostic.open_float, { desc = 'Show Diagnostics' })
set('n', '<F2>', vim.lsp.buf.rename, { desc = 'Rename' })
set('n', '<F3>', vim.lsp.buf.format, { desc = 'Format buffer using attached lsp' })
set('n', '<F4>', vim.lsp.buf.code_action, { desc = 'Code action' })
set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Previous diagnostics' })
set('n', ']d', vim.diagnostic.goto_next, { desc = 'Next diagnostics' })
--]]
