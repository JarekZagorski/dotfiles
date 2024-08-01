local telescope = require('telescope.builtin')

-- some utility functions

--- Set keymap for normal mode
---@param lhs string Keymap to be set
---@param rhs string | function What is executed
---@param desc? string Description of what it is
local function nmap(lhs, rhs, desc)
    vim.keymap.set('n', lhs, rhs, { desc = desc })
end

-- Telescope
--vim.keymap.set('n', '<C-p>', telescope.git_files, {})
-- Neotree
--vim.keymap.set("n", "<leader>pv", vim.cmd.Neotree)
-- Fugitive
nmap('<leader>gs', vim.cmd.Git, 'Git Fugitive: git status')
-- Harpoon
local mark = require('harpoon.mark')
local harpoon_ui = require('harpoon.ui')

nmap('<leader>a', mark.add_file)
nmap('<C-e>', harpoon_ui.toggle_quick_menu, 'Harpoon: Toggle quick menu')
nmap('<C-h>', function() harpoon_ui.nav_file(1) end, 'Harpoon: file 1')
nmap('<C-j>', function() harpoon_ui.nav_file(2) end, 'Harpoon: file 2')
nmap('<C-k>', function() harpoon_ui.nav_file(3) end, 'Harpoon: file 3')
nmap('<C-l>', function() harpoon_ui.nav_file(4) end, 'Harpoon: file 4')

-- <leader> segment
nmap('<leader>ff', telescope.find_files, 'Find File')
nmap('<leader>fg', telescope.live_grep, 'File Grep')
nmap('<leader>pv', '<cmd>Neotree position=current <cr>', 'Project View')
nmap('<leader>y', 'V"+y', 'Yank line to clipboard')

--[ lsp-zero descriptions
nmap('K', vim.lsp.buf.hover, 'Display Hover Information')
nmap('gd', vim.lsp.buf.definition, 'Jump to definition')
nmap('gD', vim.lsp.buf.declaration, 'Jump to Declaration')
nmap('gi', vim.lsp.buf.implementation, 'List implementations')
nmap('go', vim.lsp.buf.type_definition, 'Jump to type definition')
nmap('gr', vim.lsp.buf.references, 'List all references')
nmap('gs', vim.lsp.buf.signature_help, 'Display signature information')
nmap('gl', vim.diagnostic.open_float, 'Show Diagnostics')
nmap('<F2>', vim.lsp.buf.rename, 'Rename')
nmap('<F3>', vim.lsp.buf.format, 'Format buffer using attached lsp')
nmap('<F4>', vim.lsp.buf.code_action, 'Code action')
nmap('[d', vim.diagnostic.goto_prev, 'Previous diagnostics')
nmap(']d', vim.diagnostic.goto_next, 'Next diagnostics')
--]]
