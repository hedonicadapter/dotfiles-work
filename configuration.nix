{
  pkgs,
  system,
  neovim-flake,
  ...
}: {
  nix.enable = false;
  nixpkgs.config.allowUnfree = true;

  users.users.samherman1 = {
    name = "samherman1";
    home = "/Users/samherman1";
  };

  environment.systemPackages = with pkgs; [
    vim
    neovim-flake.packages.${system}.nvim
    git
    # homerow # TODO: build from source
    brave
  ];

  services = {
    aerospace = {
      enable = true;
      settings = {
        on-focus-changed = ["move-mouse window-lazy-center"];
        mode.main.binding = {
          "alt-m" = "fullscreen";
          "alt-w" = "close";

          "alt-h" = "focus left";
          "alt-j" = "focus down";
          "alt-k" = "focus up";
          "alt-l" = "focus right";

          "alt-shift-h" = "move left";
          "alt-shift-j" = "move down";
          "alt-shift-k" = "move up";
          "alt-shift-l" = "move right";

          "alt-shift-f" = "layout floating tiling";

          "alt-ctrl-h" = "resize width -30";
          "alt-ctrl-j" = "resize height +30";
          "alt-ctrl-k" = "resize height -30";
          "alt-ctrl-l" = "resize width +30";

          "alt-1" = "workspace 1";
          "alt-2" = "workspace 2";
          "alt-3" = "workspace 3";
          "alt-4" = "workspace 4";
          "alt-5" = "workspace 5";
          "alt-6" = "workspace 6";
          "alt-7" = "workspace 7";
          "alt-8" = "workspace 8";
          "alt-9" = "workspace 9";
          "alt-0" = "workspace 10";

          "alt-shift-1" = ["move-node-to-workspace 1" "workspace 1"];
          "alt-shift-2" = ["move-node-to-workspace 2" "workspace 2"];
          "alt-shift-3" = ["move-node-to-workspace 3" "workspace 3"];
          "alt-shift-4" = ["move-node-to-workspace 4" "workspace 4"];
          "alt-shift-5" = ["move-node-to-workspace 5" "workspace 5"];

          "alt-shift-c" = "reload-config";
        };
      };
    };
  };

  system = {
    keyboard = {
      enableKeyMapping = true;
      remapCapsLockToEscape = true;
      swapLeftCtrlAndFn = true;
    };
    defaults = {
      dock = {
        autohide = true;
      };

      CustomSystemPreferences = {
        "/var/root/Library/Preferences/com.apple.CoreBrightness.plist" = let
          userId = builtins.readFile (pkgs.runCommand "user-id" {} "/usr/bin/dscl . -read /Users/samherman1 GeneratedUID | /usr/bin/sed 's/GeneratedUID: //' | /usr/bin/tr -d \\\\n > $out");
        in {
          "CBUser-${userId}" = {
            CBBlueLightReductionCCTTargetRaw = "3433.05";
            CBBlueReductionStatus = {
              AutoBlueReductionEnabled = 1;
              BlueLightReductionAlgoOverride = 0;
              BlueLightReductionDisableScheduleAlertCounter = 3;
              BlueLightReductionSchedule = {
                DayStartHour = 7;
                DayStartMinute = 0;
                NightStartHour = 22;
                NightStartMinute = 0;
              };
              BlueReductionAvailable = 1;
              BlueReductionEnabled = 0;
              BlueReductionMode = 1;
              BlueReductionSunScheduleAllowed = 1;
              Version = 1;
            };
            CBColorAdaptationEnabled = 1;
          };
        };
      };
    };
  };

  nix.settings.experimental-features = "nix-command flakes";

  system.stateVersion = 6;
  nixpkgs.hostPlatform = pkgs.system;
}
