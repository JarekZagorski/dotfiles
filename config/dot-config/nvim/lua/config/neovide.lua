if not vim.g.neovide then
  return
end

vim.g.neovide_opacity = 0.5
vim.g.neovide_normal_opacity = 0.5

-- animation settings
vim.g.neovide_cursor_animation_length = 0.040
vim.g.neovide_cursor_short_animation_length = 0.03

-- add shortcuts to support copy and paste from clipboard, per wezterm experience
vim.keymap.set({ 'n', 'v' }, '<C-S-c>', '"+y', { desc = 'Copy to clipboard' })

-- set of paste commands
vim.keymap.set('v', '<C-S-v>', '"+P', { desc = 'Paste from clipboard' })
vim.keymap.set('i', '<C-S-v>', '<ESC>"+Pa', { desc = 'Paste from clipboard' })
vim.keymap.set('c', '<C-S-v>', '<C-r>+', { desc = 'Paste from clipboard' })
