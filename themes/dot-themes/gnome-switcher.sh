#!/bin/bash

help () {
    echo "Usage: $0 MODE"
    echo ""
    echo "Available modes:"
    echo " - light"
    echo " - dark"
}


config=${XDG_CONFIG_HOME:-$HOME/.config}

if [[ $1 == dark ]]; then
    sleep 1
	dconf write /org/gnome/shell/extensions/user-theme/name "'Tokyonight-Dark'"
	dconf write /org/gnome/desktop/interface/icon-theme "'Tokyonight-Dark'"
	dconf write /org/gnome/desktop/interface/gtk-theme "'Tokyonight-Dark'"
    echo "import = [ '$config/alacritty/alacritty-auto-theme/dark_theme.toml' ]" > $config/alacritty/alacritty-auto-theme/theme.toml
    $HOME/.themes/libadwaita-theme-changer/libadwaita-tc.py --gsettings
	echo "Dark"
elif [[ $1 == light ]]; then
    sleep 1
	dconf write /org/gnome/shell/extensions/user-theme/name "'Tokyonight-Light'"
	dconf write /org/gnome/desktop/interface/icon-theme "'Tokyonight-Light'"
	dconf write /org/gnome/desktop/interface/gtk-theme "'Tokyonight-Light'"
    echo "import = [ '$config/alacritty/alacritty-auto-theme/light_theme.toml' ]" > $config/alacritty/alacritty-auto-theme/theme.toml
    $HOME/.themes/libadwaita-theme-changer/libadwaita-tc.py --gsettings
	echo "Light"
else
    help
fi

# Setup: 
# Download this script and paste it in ~/.themes
# Make it executable by chmod +x
# Use the theme name that you want
