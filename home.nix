let
  traceVal = v: builtins.trace v v;
  linkFile = { file, path, recursive ? false } : {
     "${path}" = { source = ./dotfiles/${file}; recursive = recursive; };
  };
  gnomeShellTheme = rec {
    available = [
      "Default" 
      "Tokyonight-Dark-BL"
    ];
    name = builtins.elemAt available 1;
    isCustom = name != builtins.elemAt available 0;
    loadFiles = if isCustom then
      let libAdw = f: linkFile { 
          file = "themes/${name}/${f}"; 
          path = ".config/${f}";
          recursive = false;
      }; in
      linkFile { file = "themes/${name}"; path = ".themes/${name}"; }
      # libadwaita theme
      // libAdw "gtk-4.0/gtk.css"
      // libAdw "gtk-4.0/gtk-dark.css"
      // libAdw "gtk-4.0/assets"
    else {};
  };
  
  # generates attrSet for adding to .config
  addConfig = l: linkFile { file = l; path = ".config/${l}"; };
in { config, pkgs, lib, ... }: rec {
  home.username = "jordynski";
  home.homeDirectory = "/home/jordynski";

  dconf = {
    enable = true;
    settings."org/gnome/shell/extensions/user-theme" = { 
      name = gnomeShellTheme.name; 
    };
    settings."org/gnome/shell".enabled-extensions = [
      "user-theme@gnome-shell-extensions.gcampax.github.com"
    ];
    settings."org/gnome/shell".disabled-extensions = [];
    settings."org/gnome/desktop/interface" = {
      icon-theme = "Tokyonight-Moon";
      # theme for legacy apps
      gtk-theme = gnomeShellTheme.name;
    };
    settings."org/gnome/desktop/background" = {
      picture-uri-dark = traceVal "file://${home.homeDirectory}/.config/wallpapers/images/alx-colorful-clouds.png"; 
      picture-options = "scaled";
      primary-color = "000000";
      secondary-color = "000000";
    };
    settings."org/gnome/mutter" = { dynamic-workspaces = true; };
    settings."org/gnome/desktop/peripherals/touchpad" = { tap-to-click = true; };
  };

  home.packages = with pkgs; [
    neofetch

    # archives
    zip
    unzip

    # utils
    ripgrep # recursively searches directories for a regex pattern
    fzf # A command-line fuzzy finder

    # nix related
    # it provides the command `nom` works just like `nix`
    # with more details log output
    nix-output-monitor

    # general utils
    alacritty
    zellij
    fish
    gnome.dconf-editor
    gnome.gnome-tweaks  # only for devtime
    htop

    # devtools
    nodejs_21
    python3
    gnumake

    # gaming
    steam
  ];

  home.file = {}
    // addConfig "fish" 
    // addConfig "nvim" 
    // addConfig "tmux" 
    // addConfig "zellij" 
    // addConfig "alacritty" 
    // addConfig "git/git_aliases.inc"
    // linkFile rec { file = "fonts"; path = ".${file}"; }
    // linkFile rec { file = "icons/Tokyonight-Moon"; path = ".${file}"; }
    // linkFile rec { file = "wallpapers/images"; path = ".config/${file}"; recursive = true; }
    // gnomeShellTheme.loadFiles
  ;

  # basic configuration of git
  programs.git = {
    enable = true;
    userName = "Jarek Zagorski";
    userEmail = "me.kubolski@gmail.com";
    extraConfig = {
        include = {
            path = "${home.homeDirectory}/.config/git/git_aliases.inc";
        };
    };
  };

  programs.neovim = {
    viAlias = true;
    vimAlias = true;
    enable = true;
    defaultEditor = true;
    # unfortunately, treesitter needs to be configured the NixOS way
  };

  # programs.firefox = {
  #   profiles.jordynski = {
  #   };
  # };

  # This value determines the home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update home Manager without changing this value. See
  # the home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "23.11";

  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;
}
