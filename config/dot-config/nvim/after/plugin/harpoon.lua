-- Harpoon
local harpoon = require('harpoon')
local lib = require 'custom.lib'

harpoon:setup()

vim.keymap.set('n', '<leader>a', function() harpoon:list():add() end, { desc = 'Harpoon: add file' })
vim.keymap.set('n', '<C-e>', function() harpoon.ui:toggle_quick_menu(harpoon:list()) end,
    { desc = 'Harpoon: toggle menu' })
vim.keymap.set('n', '<C-j>', function() harpoon:list():select(1) end, { desc = 'Harpoon: file 1' })
vim.keymap.set('n', '<C-k>', function() harpoon:list():select(2) end, { desc = 'Harpoon: file 2' })
vim.keymap.set('n', '<C-l>', function() harpoon:list():select(3) end, { desc = 'Harpoon: file 3' })
vim.keymap.set('n', '<C-;>', function() harpoon:list():select(4) end, { desc = 'Harpoon: file 4' })


--[[

lib.nmap('<leader>a', mark.add_file)
lib.nmap('<C-e>', harpoon_ui.toggle_quick_menu, 'Harpoon: Toggle quick menu')
lib.nmap('<C-j>', function() harpoon_ui.nav_file(1) end, 'Harpoon: file 1')
lib.nmap('<C-k>', function() harpoon_ui.nav_file(2) end, 'Harpoon: file 2')
lib.nmap('<C-l>', function() harpoon_ui.nav_file(3) end, 'Harpoon: file 3')
lib.nmap('<C-;>', function() harpoon_ui.nav_file(4) end, 'Harpoon: file 4')

--]]
