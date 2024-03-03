let
  traceVal = v: builtins.trace v v;
  linkFile = { file, path, recursive ? false } : {
     "${path}" = { source = ./dotfiles/${file}; recursive = recursive; };
  };
  username = "jordynski";
  home = "/home/${username}";
  gnomeConf = import ./home/dconf.nix { homeDir = home; };
  # generates attrSet for adding to .config
  addConfig = l: linkFile { file = l; path = ".config/${l}"; recursive = false; };
  addConfigRec = l: linkFile { file = l; path = ".config/${l}"; recursive = true; };
in { config, pkgs, lib, ... }: rec {
  home.username = username;
  home.homeDirectory = home;

  dconf = gnomeConf.dconf;

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
    file
    patchelf

    # devtools
    nodejs_21
    python3
    gnumake
    dos2unix  # changes endlines to conform with unix spec
    go
    zig
    cargo

    # libs
    zlib

    # gaming
    steam
  ];

  home.file = {}
    // addConfig "tmux" 
    // addConfig "zellij" 
    // addConfig "alacritty" 
    // addConfig "git/git_aliases.inc"
    // addConfigRec "fish" 
    // addConfigRec "nvim" 
    // linkFile rec { file = "fonts"; path = ".${file}"; }
    // linkFile rec { file = "icons/Tokyonight-Moon"; path = ".${file}"; }
    // linkFile rec { file = "wallpapers/images"; path = ".config/${file}"; recursive = true; }
    // gnomeConf.loadFiles
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
