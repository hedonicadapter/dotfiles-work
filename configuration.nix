{
  pkgs,
  system,
  neovim-flake,
  colors-flake,
  ...
}: {
  nix.enable = false;
  nixpkgs.config.allowUnfree = true;

  users.users.samherman1 = {
    name = "samherman1";
    home = "/Users/samherman1";
  };

  environment.systemPackages = with pkgs; [
    # intune-portal
    vim
    neovim-flake.packages.${system}.nvim
    git
    # homerow # TODO: build from source
    brave
  ];

  nixpkgs.overlays = [
    (self: super: {
      karabiner-elements = super.karabiner-elements.overrideAttrs (old: {
        version = "14.13.0";

        src = super.fetchurl {
          inherit (old.src) url;
          hash = "sha256-gmJwoht/Tfm5qMecmq1N6PSAIfWOqsvuHU8VDJY8bLw=";
        };
      });
    })
  ];
  services = {
    karabiner-elements.enable = true;
    jankyborders = {
      enable = true;
      hidpi = true;
      width = 8.0;
      order = "above";
      active_color = colors-flake.hexColorTo0xAARRGGBB colors-flake.colors.base07 1.0;
      inactive_color = colors-flake.hexColorTo0xAARRGGBB colors-flake.colors.base05 1.0;
    };
  };

  system = {
    keyboard = {
      enableKeyMapping = true;
      remapCapsLockToEscape = true;
      swapLeftCtrlAndFn = true;
    };
    defaults = {
      ".GlobalPreferences"."com.apple.mouse.scaling" = 1.0; # mouse accel
      dock = {
        autohide = true;
      };

      NSGlobalDomain = {
        KeyRepeat = 1;
        InitialKeyRepeat = 1;
        AppleShowAllFiles = true; # finder hidden files
        NSWindowShouldDragOnGesture = true; # ctrl + cmd + drag = drag windows
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
