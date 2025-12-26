local M = {
  'nvim-orgmode/orgmode',
  event = 'VeryLazy',
  ft = 'org',
}

function M.config()
  require('orgmode').setup({
    org_agenda_files = '~/orgfiles/**/*',
    org_default_notes_file = '~/orgfiles/refile.org',
  })
end

return M
