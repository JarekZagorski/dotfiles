let
  traceVal = v: builtins.trace v v;
  dotfilesDir = "dotfiles";
  username = "jordynski";
  homeDir = "/home/${username}";
  gnomeConf = import ./home/dconf.nix { 
    homeDir = homeDir; 
    dotfilesDir = dotfilesDir; 
  };
  # generates attrSet for adding to .config
  linkFiles = targetDir: recursive: builtins.foldl' (acc: e: 
    acc // { "${targetDir}/${e}" = {
        source = ./${dotfilesDir}/${e}; 
        recursive = recursive;
        target = "${targetDir}/${e}";
    };}
  ) {};
in { config, pkgs, lib, ... }: rec {
  home.username = username;
  home.homeDirectory = homeDir;

  dconf = gnomeConf.dconf lib;

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
    gnome.gnome-tweaks  # only for devtime TODO: remove
    htop
    file
    spotify

    # for proper application of themes
    gnome.gnome-themes-extra
    gtk-engine-murrine

    # devtools
    nodejs_21
    python3
    gnumake
    zig
    cargo
    go
    marksman

    # gaming
    steam

    # system stuff
    nix-index
    patchelf
  ];

  home.file = {}
    // (let linkConfig = linkFiles ".config"; in
      linkConfig false [
        "tmux"
        "zellij" 
        "alacritty"
        "git/git_aliases.inc"
      ] 
      // linkConfig true [ "fish" "nvim" ]
    )
    // linkFiles ".local/share" false [ "fonts" ]
    // gnomeConf.loadFiles
  ;

  home.sessionVariables = { EDITOR = "nvim"; };

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
  #   profiles.${username} = {
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
