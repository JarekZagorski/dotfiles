local wezterm = require 'wezterm'

-- The filled in variant of the < symbol
local SOLID_LEFT_ARROW = wezterm.nerdfonts.pl_right_hard_divider

-- The filled in variant of the > symbol
local SOLID_RIGHT_ARROW = wezterm.nerdfonts.pl_left_hard_divider

-- This function returns the suggested title for a tab.
-- It prefers the title that was set via `tab:set_title()`
-- or `wezterm cli set-tab-title`, but falls back to the
-- title of the active pane in that tab.
function tab_title(tab_info)
    local title = tab_info.tab_title
    -- if the tab title is explicitly set, take that
    if title and #title > 0 then
        return title
    end
    -- Otherwise, use the title from the active pane
    -- in that tab
    return tab_info.active_pane.title
end

--[[
wezterm.on(
    'format-tab-title',
    function(tab, tabs, panes, config, hover, max_width)
        local edge_background = '#0b0022'
        local background = '#1b1032'
        local foreground = '#808080'

        if tab.is_active then
            background = '#2b2042'
            foreground = '#c0c0c0'
        elseif hover then
            background = '#3b3052'
            foreground = '#909090'
        end

        local edge_foreground = background

        local title = tab_title(tab)

        -- ensure that the titles fit in the available space,
        -- and that we have room for the edges.
        title = wezterm.truncate_right(title, max_width - 2)

        return {
            -- { Background = { Color = edge_background } },
            -- { Foreground = { Color = edge_foreground } },
            { Text = SOLID_LEFT_ARROW },
            -- { Background = { Color = background } },
            -- { Foreground = { Color = foreground } },
            { Text = title },
            -- { Background = { Color = edge_background } },
            -- { Foreground = { Color = edge_foreground } },
            { Text = SOLID_RIGHT_ARROW },
        }
    end
)

--]]

-- wezterm.gui is not available to the mux server, so take care to
-- do something reasonable when this config is evaluated by the mux
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

return {
    automatically_reload_config = true,

    color_scheme = get_scheme(get_appearance()),

    font = wezterm.font "Fira Code",
    font_size = 12.0,

    window_decorations = "RESIZE",

    window_padding = {
        left = 1,
        right = 0,
        top = 0,
        bottom = 0,
    },

    hide_tab_bar_if_only_one_tab = true,
    use_fancy_tab_bar = false,
}
