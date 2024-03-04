let 
    traceVal = v: builtins.trace v v;
in
{ homeDir, dotfilesDir } : rec {
    gnomeTheme = rec {
        available = [
            "Default" 
            # TODO: wait for fixed tokyonight theme for gnome shell :(
            "Tokyonight-Dark-BL"
            # these are dev-preview
            "Tokyionight-Dark"
            "Tokyionight-Moon"
            "Tokyionight"
        ];
        name = builtins.elemAt available 1;
        isCustom = name != builtins.elemAt available 0;
        iconTheme = "Tokyonight-Moon";
    };
    loadFiles = if gnomeTheme.isCustom then
        let libAdw = f: { ".config/${f}" = {
            source = ../${dotfilesDir}/themes/${gnomeTheme.name}/${f};
        };}; in { 
            ".themes/${gnomeTheme.name}" = {
                source = ../${dotfilesDir}/themes/${gnomeTheme.name};
            };
            # link icon set
            ".icons/${gnomeTheme.iconTheme}" = {
                source = ../${dotfilesDir}/icons/${gnomeTheme.iconTheme};
            };
            ".config/wallpapers/images" = { 
                source = ../${dotfilesDir}/wallpapers/images; 
                recursive = true;
            };
        }
        # libadwaita theme
        // libAdw "gtk-4.0/gtk.css"
        // libAdw "gtk-4.0/gtk-dark.css"
        // libAdw "gtk-4.0/assets"
    else {};
    dconf = lib: {
        enable = true;
        settings = {
            "org/gnome/shell/extensions/user-theme" = { 
                name = gnomeTheme.name; 
            };
            "org/gnome/shell".enabled-extensions = [
                "user-theme@gnome-shell-extensions.gcampax.github.com"
                "mediacontrols@cliffniff.github.com"
                "date-menu-formatter@marcinjakubowski.github.com"
            ];
            "org/gnome/shell".disabled-extensions = [];
            "org/gnome/desktop/interface" = {
                icon-theme = gnomeTheme.iconTheme;
                # theme for legacy apps
                gtk-theme = gnomeTheme.name;
            };
            "org/gnome/desktop/background" = {
                picture-uri-dark = "file://${homeDir}/.config/wallpapers/images/alx-colorful-clouds.png"; 
                picture-options = "scaled";
                primary-color = "000000";
                secondary-color = "000000";
            };
            "org/gnome/mutter" = { dynamic-workspaces = true; };
            "org/gnome/desktop/peripherals/touchpad" = { tap-to-click = true; };
            "org/gnome/shell/extensions/mediacontrols" = { 
                extension-position = "Left";
                extension-index = lib.hm.gvariant.mkUint32 1;
                show-control-icons-seek-forward = false;
                show-control-icons-seek-backward = false;
                colored-player-icon = false;
                mouse-action-scroll-up = "NONE";
                mouse-action-scroll-down = "NONE";
            };
            "org/gnome/desktop/wm/preferences" = {
                button-layout = "close,minimize,maximize:appmenu";
            };
        };
    };
}
