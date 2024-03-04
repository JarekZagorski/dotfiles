let 
    traceVal = v: builtins.trace v v;
in
{ homeDir } : rec {
    gnomeTheme = rec {
        available = [
            "Default" 
            "Tokyonight-Dark-BL"
        ];
        name = builtins.elemAt available 1;
        isCustom = name != builtins.elemAt available 0;
    };
    loadFiles = if gnomeTheme.isCustom then
        let libAdw = f: { ".config/${f}" = {
            source = ../dotfiles/themes/${gnomeTheme.name}/${f};
            recursive = false;
        };}; in
        { ".themes/${gnomeTheme.name}" = {
            source = ../dotfiles/themes/${gnomeTheme.name};
            recursive = false;
        };}
        # libadwaita theme
        // libAdw "gtk-4.0/gtk.css"
        // libAdw "gtk-4.0/gtk-dark.css"
        // libAdw "gtk-4.0/assets"
    else {};
    dconf = {
        enable = true;
        settings."org/gnome/shell/extensions/user-theme" = { 
          name = gnomeTheme.name; 
        };
        settings."org/gnome/shell".enabled-extensions = [
          "user-theme@gnome-shell-extensions.gcampax.github.com"
        ];
        settings."org/gnome/shell".disabled-extensions = [];
        settings."org/gnome/desktop/interface" = {
          icon-theme = "Tokyonight-Moon";
          # theme for legacy apps
          gtk-theme = gnomeTheme.name;
        };
        settings."org/gnome/desktop/background" = {
          picture-uri-dark = "file://${homeDir}/.config/wallpapers/images/alx-colorful-clouds.png"; 
          picture-options = "scaled";
          primary-color = "000000";
          secondary-color = "000000";
        };
        settings."org/gnome/mutter" = { dynamic-workspaces = true; };
        settings."org/gnome/desktop/peripherals/touchpad" = { tap-to-click = true; };
    };
}
