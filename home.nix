{
  config,
  pkgs,
  colors-flake,
  spicetify-nix,
  lib,
  osConfig,
  ...
}: {
  home.username = "samherman1";
  home.homeDirectory = "/Users/samherman1";

  imports = [
    ./stuff/kitty.nix
    (import ./stuff/zsh.nix {inherit pkgs lib;})
    ./stuff/aerospace.nix
    # ./stuff/karabiner-elements.nix
  ];

  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    # darwin.xcode
    appcleaner
    zoxide
    raycast
    slack
    autoraise
    aider-chat # ai chat
  ];

  stylix = {
    enable = true;
    base16Scheme = colors-flake.colors;
  };

  # programs.zen-browser = {
  #   enable = true;
  #   policies = {
  #     DisableAppUpdate = true;
  #     DisableTelemetry = true;
  #   };
  # };

  programs.gpg = {
    enable = true;
  };
  services.gpg-agent = {
    enable = true;
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    enableZshIntegration = true;
  };

  programs.atuin = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      dialect = "uk";
      update_check = false;
      sync_frequency = 0;
      filter_mode = "directory";
      style = "compact";
      enter_accept = true;
      keymap_mode = "vim-insert";
    };
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.git = {
    enable = true;
    userName = "hedonicadapter";
    userEmail = "sam.herman@xenit.se";
    extraConfig = {
      init.defaultBranch = "main";
      credential.helper = "${
        pkgs.git.override {withLibsecret = true;}
      }/bin/git-credential-libsecret";

      color.ui = "auto";

      delta = {
        navigate = true;
      };
      merge = {
        conflictstyle = "zdiff3";
      };

      push = {
        autoSetupRemote = true;
      };
    };
    delta .enable = true;
  };

  programs.spicetify = let
    spicePkgs = spicetify-nix.legacyPackages.${pkgs.system};
  in {
    enable = true;
    enabledCustomApps = with spicePkgs.apps; [
      newReleases
      lyricsPlus
      localFiles
    ];
    enabledExtensions = with spicePkgs.extensions; [
      autoSkipVideo
      adblock
      shuffle
    ];
    experimentalFeatures = true;
    alwaysEnableDevTools = true;
    # theme = spicePkgs.themes.dribbblishDynamic;
    # colorScheme = "custom";
    # customColorScheme = {
    #   text = "f8f8f8";
    #   subtext = "f8f8f8";
    #   sidebar-text = "79dac8";
    #   main = "000000";
    #   sidebar = "323437";
    #   player = "000000";
    #   card = "000000";
    #   shadow = "000000";
    #   selected-row = "7c8f8f";
    #   button = "74b2ff";
    #   button-active = "74b2ff";
    #   button-disabled = "555169";
    #   tab-active = "80a0ff";
    #   notification = "80a0ff";
    #   notification-error = "e2637f";
    #   misc = "282a36";
    # };
  };

  home.file = {
    ".oh-my-zsh/custom/themes" = {
      source = ./stuff/oh-my-zsh/themes;
      recursive = true;
    };
  };

  home.sessionVariables = {
    ZSH_CUSTOM = "${config.home.homeDirectory}/.oh-my-zsh/custom";
    TERMINAL = "kitty";
  };

  home.stateVersion = "24.11";
}
