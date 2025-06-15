-- some useful functions

local function a(f, opts)
  return function()
    f(opts)
  end
end

-- Telescope
local telescope = require('telescope.builtin')
--vim.keymap.set('n', '<C-p>', telescope.git_files, {})

-- Git
local telescope_extensions = require 'config.telescope_extensions'
vim.keymap.set('n', '<leader>gg', vim.cmd.Git, { desc = 'Git status' })
vim.keymap.set('n', '<leader>gf', telescope_extensions.fixup_picker, { desc = 'Git fixup' })

-- <leader> segment
vim.keymap.set('n', '<leader>ff', telescope.find_files, { desc = 'Find File' })
vim.keymap.set('n', '<leader>fg', telescope.live_grep, { desc = 'File Grep' })
vim.keymap.set('n', '<leader>pv', '<cmd>Yazi toggle<cr>', { desc = 'Project View' })
vim.keymap.set('v', '<leader>y', '"+y', { desc = 'Yank line to clipboard' })

-- lsp keymaps
vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = 'Display Hover Information' })
vim.keymap.set('n', 'gdd', vim.lsp.buf.definition, { desc = 'Jump to definition' })
vim.keymap.set('n', 'gdt', vim.lsp.buf.type_definition, { desc = 'Jump to type definition' })
vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { desc = 'Jump to Declaration' })
vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { desc = 'List implementations' })
vim.keymap.set('n', 'gr', vim.lsp.buf.references, { desc = 'List all references' })
vim.keymap.set('n', 'gs', vim.lsp.buf.signature_help, { desc = 'Display signature information' })
vim.keymap.set('n', 'gl', vim.diagnostic.open_float, { desc = 'Show Diagnostics' })
vim.keymap.set('n', '[d', a(vim.diagnostic.jump, { count = -1, float = true }), { desc = 'Previous diagnostics' })
vim.keymap.set('n', ']d', a(vim.diagnostic.jump, { count = 1, float = true }), { desc = 'Next diagnostics' })

--------------------
--- code actions ---
--------------------

vim.keymap.set('n', '<leader>cr', vim.lsp.buf.rename, { desc = 'Code rename' })
vim.keymap.set('n', '<leader>cf', vim.lsp.buf.format, { desc = 'Code format buffer using attached lsp' })
vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { desc = 'Code action' })
vim.keymap.set('n', '<leader>co', a(vim.lsp.buf.code_action, {
  filter = function(x) return x.kind == "source.organizeImports" end,
  apply = true,
}), { desc = 'Code action: Organize Imports' })

---------------
--- harpoon ---
---------------
local harpoon = require 'harpoon'

-- required
harpoon:setup()

vim.keymap.set('n', '<leader>a', function() harpoon:list():add() end)
vim.keymap.set('n', '<C-e>', function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

vim.keymap.set('n', '<C-h>', function() harpoon:list():select(1) end)
vim.keymap.set('n', '<C-j>', function() harpoon:list():select(2) end)
vim.keymap.set('n', '<C-k>', function() harpoon:list():select(3) end)
vim.keymap.set('n', '<C-l>', function() harpoon:list():select(4) end)

---------------
--- harpoon ---
---------------
