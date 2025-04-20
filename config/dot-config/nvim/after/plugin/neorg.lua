local months = {
  'Styczeń',
  'Luty',
  'Marzec',
  'Kwiecień',
  'Maj',
  'Czerwiec',
  'Lipiec',
  'Sierpień',
  'Wrzesień',
  'Październik',
  'Listopad',
  'Grudzień',
}

require("neorg").setup {
  load = {
    ["core.defaults"] = {},
    ["core.concealer"] = {},
    ["core.dirman"] = {
      config = {
        workspaces = {
          notes = "~/notes",
        },
        default_workspace = "notes",
      },
    },
    ["core.journal"] = {
      config = {
        strategy = function ()
          local d = os.date('*t')
          return os.date('%Y/%m-') .. months[d.month] .. os.date('/%Y-%m-%d.norg')
        end
      }
    },
  },
}
