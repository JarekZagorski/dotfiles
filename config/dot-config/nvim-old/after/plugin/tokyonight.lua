---@diagnostic disable: missing-fields
require("tokyonight").setup({
    style = 'night',
    ligt_style = 'day',
    transparent = false,
    styles = {
        -- Style to be applied to different syntax groups
        -- Value is any valid attr-list value for `:help nvim_set_hl`
        comments = { italic = true },
        keywords = { italic = true },
        functions = {},
        variables = {},
        -- Background styles. Can be "dark", "transparent" or "normal"
        sidebars = "dark", -- style for sidebars, see below
        floats = "dark", -- style for floating windows
    },
    sidebars = { "qf", "help" },
})

require('auto-dark-mode').setup({
        update_interval = 1000,
        set_dark_mode = function()
            vim.cmd("colorscheme tokyonight-night")
        end,
        set_light_mode = function()
            vim.cmd("colorscheme tokyonight-day")
        end,
        fallback = "light",
    }
)
