local wezterm = require 'wezterm'
local utils = require 'utils'

-- wezterm.gui is not available to the mux server, so take care to
-- do something reasonable when this config is evaluated by the mux
---@return Appearance
local function get_appearance()
    if wezterm.gui then
        return wezterm.gui.get_appearance()
    end
    return 'Dark'
end

local function get_scheme(appearance)
    if appearance:find 'Dark' then
        return 'Tokyo Night'
    else
        return 'Tokyo Night Day'
    end
end

local wallpapers = {
    Windows = {
        Dark = {
            image = "C:/Users/JakubOrdynski/Pictures/Wallpapers/tokyo-night33.png",
            overlay = "rgba(26, 27, 38, 0.9)"
        },
        Light = {
            image = "C:/Users/JakubOrdynski/Pictures/Wallpapers/rur2ErE.jpeg",
            overlay = "rgba(255, 255, 255, 0.8)"
        }
    },
    Unix = {
        Dark = {
            image = "/home/jakub/dotfiles/wallpapers/tokyo-night/tokyo-night33.png",
            overlay = "rgba(26, 27, 38, 0.9)"
        },
        Light = {
            image = "/home/jakub/dotfiles/wallpapers/rur2ErE.jpeg",
            overlay = "rgba(255, 255, 255, 0.8)"
        }
    },
}

local function get_background(appearance)
    local data = wallpapers[utils.get_os()][appearance]
    return {
        -- {
        --     source = {
        --         File = data.image,
        --     },
        -- },
        {
            source = {
                Color = data.overlay,
            },
            height = "100%",
            width = "100%",
        },
    }
end

-- some basic config
local config = wezterm.config_builder()
config.automatically_reload_config = true
config.font = wezterm.font "Fira Code"
config.font_size = 12.0 -- 11 on windows
config.hide_tab_bar_if_only_one_tab = true
config.window_decorations = "RESIZE"
config.color_scheme = get_scheme(get_appearance())
config.background = get_background(get_appearance())

local linux_config = {
    window_padding = {
        left = 1,
        right = 0,
        top = 0,
        bottom = 0,
    },

    use_fancy_tab_bar = false,
}

-- and finally, return the configuration to wezterm
local windows_config = {
    leader = { key = 'a', mods = 'CTRL' },

    default_prog = { 'nu' },

    background = get_background(get_appearance()),

    keys = {
        { key = "a",  mods = "LEADER|CTRL",  action = wezterm.action { SendString = "\x01" } },
        { key = "-",  mods = "LEADER",       action = wezterm.action { SplitVertical = { domain = "CurrentPaneDomain" } } },
        { key = "\\", mods = "LEADER",       action = wezterm.action { SplitHorizontal = { domain = "CurrentPaneDomain" } } },
        { key = "s",  mods = "LEADER",       action = wezterm.action { SplitVertical = { domain = "CurrentPaneDomain" } } },
        { key = "v",  mods = "LEADER",       action = wezterm.action { SplitHorizontal = { domain = "CurrentPaneDomain" } } },
        -- { key = "o",  mods = "LEADER",       action = "TogglePaneZoomState" },
        { key = "z",  mods = "LEADER",       action = "TogglePaneZoomState" },
        { key = "c",  mods = "LEADER",       action = wezterm.action { SpawnTab = "CurrentPaneDomain" } },
        { key = "h",  mods = "LEADER",       action = wezterm.action { ActivatePaneDirection = "Left" } },
        { key = "j",  mods = "LEADER",       action = wezterm.action { ActivatePaneDirection = "Down" } },
        { key = "k",  mods = "LEADER",       action = wezterm.action { ActivatePaneDirection = "Up" } },
        { key = "l",  mods = "LEADER",       action = wezterm.action { ActivatePaneDirection = "Right" } },
        { key = "H",  mods = "LEADER|SHIFT", action = wezterm.action { AdjustPaneSize = { "Left", 5 } } },
        { key = "J",  mods = "LEADER|SHIFT", action = wezterm.action { AdjustPaneSize = { "Down", 5 } } },
        { key = "K",  mods = "LEADER|SHIFT", action = wezterm.action { AdjustPaneSize = { "Up", 5 } } },
        { key = "L",  mods = "LEADER|SHIFT", action = wezterm.action { AdjustPaneSize = { "Right", 5 } } },
        { key = "1",  mods = "LEADER",       action = wezterm.action { ActivateTab = 0 } },
        { key = "2",  mods = "LEADER",       action = wezterm.action { ActivateTab = 1 } },
        { key = "3",  mods = "LEADER",       action = wezterm.action { ActivateTab = 2 } },
        { key = "4",  mods = "LEADER",       action = wezterm.action { ActivateTab = 3 } },
        { key = "5",  mods = "LEADER",       action = wezterm.action { ActivateTab = 4 } },
        { key = "6",  mods = "LEADER",       action = wezterm.action { ActivateTab = 5 } },
        { key = "7",  mods = "LEADER",       action = wezterm.action { ActivateTab = 6 } },
        { key = "8",  mods = "LEADER",       action = wezterm.action { ActivateTab = 7 } },
        { key = "9",  mods = "LEADER",       action = wezterm.action { ActivateTab = 8 } },
        { key = "&",  mods = "LEADER|SHIFT", action = wezterm.action { CloseCurrentTab = { confirm = true } } },
        { key = "d",  mods = "LEADER",       action = wezterm.action { CloseCurrentPane = { confirm = true } } },
        { key = "x",  mods = "LEADER",       action = wezterm.action { CloseCurrentPane = { confirm = true } } },

        -- custom part
        { key = "n",  mods = "LEADER",       action = wezterm.action.ActivateTabRelative(1) },
        { key = "p",  mods = "LEADER",       action = wezterm.action.ActivateTabRelative(-1) },
        { key = 'f',  mods = 'LEADER',       action = wezterm.action.ToggleFullScreen },
    }
}

local bonus_config = {
    Windows = windows_config,
    Unix = linux_config,
}

utils.merge_tables(config, bonus_config[utils.get_os()])

return config
