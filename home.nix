let
  traceVal = v: builtins.trace v v;
  mirrorSet = l: builtins.foldl' l (x: acc: acc // {"${x}" = x; }) {};
  linkFile = { folder, path, recursive ? true } : {
     "${path}" = { source = ./dotfiles/${folder}; recursive = recursive; };
  };
  shellTheme = rec {
    available = [
      "Default" 
      "Tokyonight-Dark-BL"
    ];
    name = builtins.elemAt available 1;
    isCustom = name != builtins.elemAt available 0;
    loadFiles = if isCustom then 
      linkFile { folder = "themes/${name}"; path = ".themes/${name}"; }
    else {};
  };
  
  # generates attrSet for adding to .config
  addConfig = l: linkFile { folder = l; path = ".config/${l}"; };
in { config, pkgs, lib, ... }: {
  home.username = "jordynski";
  home.homeDirectory = "/home/jordynski";

  dconf = {
    enable = true;
    settings."org/gnome/shell/extensions/user-theme" = { 
      name = shellTheme.name; 
    };
    settings."org/gnome/shell".enabled-extensions = [
      "user-theme@gnome-shell-extensions.gcampax.github.com"
    ];
    settings."org/gnome/shell".disabled-extensions = [];
    settings."org/gnome/desktop/interface" = {
      icon-theme = "Tokyonight-Moon";
    };
    settings."org/gnome/desktop/background" = {
      picture-uri = ".config/wallpapers/images/alx-colorful-clouds.png"; 
      picture-options = "scaled";
      primary-color = "000000";
      secondary-color = "FFFFFF";
    };
  };

  # link the configuration file in current directory to the specified location in home directory
  # home.file.".config/i3/wallpaper.jpg".source = ./wallpaper.jpg;

  # link all files in `./scripts` to `~/.config/i3/scripts`
  # home.file.".config/i3/scripts" = {
  #   source = ./scripts;
  #   recursive = true;   # link recursively
  #   executable = true;  # make all files executable
  # };

  # encode the file content in nix configuration file directly
  # home.file.".xxx".text = ''
  #     xxx
  # '';

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    neofetch
    nnn # terminal file manager

    # archives
    zip
    unzip

    # utils
    ripgrep # recursively searches directories for a regex pattern
    fzf # A command-line fuzzy finder

    # nix related
    #
    # it provides the command `nom` works just like `nix`
    # with more details log output
    nix-output-monitor

    # custom
    htop
    fish

    # general utils
    alacritty
    zellij
    fish
    gnome.dconf-editor
    gnome.gnome-tweaks

    # programs
    nodejs_21
    python3
  ];

  # adding all dotfiles to .config/ does not work well
  # adding them one after another
  home.file = {} //
    // addConfig "tmux" 
    // addConfig "fish" 
    // addConfig "zellij" 
    // addConfig "alacritty" 
    // addConfig "nvim" 
    // addConfig "wallpapers"
    // linkFile { folder = "fonts"; path = ".fonts"; }
    // linkFile { folder = "icons/Tokyonight-Moon"; path = ".icons/Tokyonight-Moon"; }
    // shellTheme.loadFiles
  ;

  # basic configuration of git
  programs.git = {
    enable = true;
    userName = "Jarek Zagorski";
    userEmail = "me.kubolski@gmail.com";
  };

  programs.neovim = {
    viAlias = true;
    vimAlias = true;
    enable = true;
    defaultEditor = true;
    # unfortunately, treesitter needs to be configured the NixOS way
  };

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
