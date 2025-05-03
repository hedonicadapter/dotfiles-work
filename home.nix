{
  config,
  pkgs,
  osConfig,
  ...
}: {
  home.username = "samherman1";
  home.homeDirectory = "/Users/samherman1";

  imports = [
    ./stuff/kitty.nix
    (import ./stuff/zsh.nix {inherit pkgs;})
  ];

  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    # darwin.xcode
    appcleaner
    zoxide
  ];

  # programs.zen-browser = {
  #   enable = true;
  #   policies = {
  #     DisableAppUpdate = true;
  #     DisableTelemetry = true;
  #   };
  # };

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

  home.file = {
    ".oh-my-zsh/custom/themes" = {
      source = ./stuff/oh-my-zsh/themes;
      recursive = true;
    };
  };

  home.sessionVariables = {
    ZSH_CUSTOM = "${config.home.homeDirectory}/.oh-my-zsh/custom";
  };

  home.stateVersion = "24.11";
}
