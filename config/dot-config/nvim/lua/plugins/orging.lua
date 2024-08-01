return {
    {
        -- replacement for basic orgmode
        "nvim-neorg/neorg",
        lazy = false,  -- Disable lazy loading as some `lazy.nvim` distributions set `lazy = true` by default
        version = "*", -- Pin Neorg to the latest stable release
        config = true,
        opts = {
            load = {
                ["core.defaults"] = {},
                ["core.concealer"] = {
                    config = {
                        icon_preset = "varied",
                    },
                },
                ["core.completion"] = {
                    config = {
                        engine = "nvim-cmp",
                    }
                },
                ["core.integrations.nvim-cmp"] = {},
            }
        },
    }
}
