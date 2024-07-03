#!/bin/bash

sleep 1

if [[ $1 == dark ]]; then
	dconf write /org/gnome/shell/extensions/user-theme/name "'Tokyonight-Dark'"
	dconf write /org/gnome/desktop/interface/icon-theme "'Tokyonight-Dark'"
	dconf write /org/gnome/desktop/interface/gtk-theme "'Tokyonight-Dark'"
    echo "import = [ '~/.config/alacritty/alacritty-auto-theme/dark_theme.toml' ]" > /home/jakub/.config/alacritty/alacritty-auto-theme/theme.toml
    /home/jakub/.themes/libadwaita-theme-changer/libadwaita-tc.py --gsettings
	echo "Dark"
else
	dconf write /org/gnome/shell/extensions/user-theme/name "'Tokyonight-Light'"
	dconf write /org/gnome/desktop/interface/icon-theme "'Tokyonight-Light'"
	dconf write /org/gnome/desktop/interface/gtk-theme "'Tokyonight-Light'"
    echo "import = [ '~/.config/alacritty/alacritty-auto-theme/light_theme.toml' ]" > /home/jakub/.config/alacritty/alacritty-auto-theme/theme.toml
    /home/jakub/.themes/libadwaita-theme-changer/libadwaita-tc.py --gsettings
	echo "Light"
fi

# Setup: 
# Download this script and paste it in ~/.themes
# Make it executable by chmod +x
# Use the theme name that you want
