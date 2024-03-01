let
  # generates attrSet for adding to .config
  addConfigFolder = { l, recursive ? true } : {
      ".config/${l}" = { source = "./dotfiles/${l}"; recursive = recursive; };
  };
  files = addConfigFolder { l="fish"; };
in { config, pkgs, lib, ... }: {
  home.username = "jordynski";
  home.homeDirectory = "/home/jordynski";

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
    # here is some command line tools I use frequently
    # feel free to add your own or remove some of them

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
    zellij

    # nivm dependencies
    zig
    gcc
  ];

  # adding all dotfiles to .config/ does not work well
  # adding them one after another
  home.file."./.config/nvim/" = {
    source = ./dotfiles/nvim;
    recursive = true;
  };

  # basic configuration of git
  programs.git = {
    enable = true;
    userName = "Jarek Zagorski";
    userEmail = "me.kubolski@gmail.com";
  };

  # alacritty - a cross-platform, GPU-accelerated terminal emulator
  programs.alacritty = {
    enable = true;
    # custom settings
    settings = {
      env.TERM = "xterm-256color";
      font = {
        size = 12;
        draw_bold_text_with_bright_colors = true;
      };
      scrolling.multiplier = 5;
      selection.save_to_clipboard = true;
    };
  };

  programs.zellij = {
    enable = true;
  };

  programs.neovim = {
    viAlias = true;
    vimAlias = true;
    enable = true;
    defaultEditor = true;
    # unfortunately, treesitter needs to be configured the NixOS way
  };

  # environment.variables.EDITOR = "nvim";
  # xdg.configFile.nvim.source = ./dotfiles/nvim;


  programs.fish = {
    enable = true;
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
