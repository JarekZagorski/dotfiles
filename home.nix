let
  linkFile = { folder, path, recursive ? true } : 
  let 
    traceVal = v: builtins.trace v v;
    oper = (traceVal "${path}/${folder}");
    src = (traceVal (./dotfiles + "/${folder}"));
  in
  {
     "${oper}" = { source = src; recursive = true; };
  };
  # generates attrSet for adding to .config
  addConfig = l: linkFile { folder = l; path = ".config"; };
in { config, pkgs, lib, ... }: {
  home.username = "jordynski";
  home.homeDirectory = "/home/jordynski";

  dconf = {
    enable = true;
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

    # programs
    nodejs_21
    python3
  ];

  # adding all dotfiles to .config/ does not work well
  # adding them one after another
  home.file = 
    addConfig "tmux" 
    // addConfig "fish" 
    // addConfig "zellij" 
    // addConfig "alacritty" 
    // addConfig "nvim" 
    // linkFile { folder = "themes"; path = "."; }
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
