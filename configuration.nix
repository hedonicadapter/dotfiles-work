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

  services = {
    jankyborders = {
      enable = true;
      # hidpi = true;
      width = 10.0;
      order = "above";
      active_color = colors-flake.hexColorTo0xAARRGGBB colors-flake.colors.base07 1.0;
      inactive_color = colors-flake.hexColorTo0xAARRGGBB colors-flake.colors.base04 1.0;
    };

    # aerospace = {
    #   enable = true;
    #   settings = {
    #     on-focus-changed = ["move-mouse window-lazy-center"];
    #     gaps = {
    #       inner.horizontal = 12;
    #       inner.vertical = 12;
    #       outer.left = "[{ monitor.main = 12 }, 32]";
    #       outer.top = 12;
    #       outer.bottom = 12;
    #       outer.right = "[{ monitor.main = 12 }, 32]";
    #     };
    #
    #     # bindd = $mainMod, R, RUN, submap, run
    #     #   bindd = , T, TERMINAL, exec, $terminal & $resetSubmap
    #     #
    #     # # Browser
    #     #   bindd = , B, DEFAULT, exec, $browser & $resetSubmap
    #     #   bindd = , F, FIREFOX, exec, firefox-beta & $resetSubmap
    #     #
    #     # # Directories
    #     #   bindd = , T, TEMP, exec, $fileManager ~/Documents/temp & $resetSubmap
    #     #   bindd = , D, DOWNLOADS, exec, $fileManager ~/Downloads & $resetSubmap
    #     #
    #     # # Query
    #     #   bindd = , A, APPS, exec, $appQuery & $resetSubmap
    #     #   bindd = , H, HOME MANAGER OPTIONS, exec, $homeManagerQuery & $resetSubmap
    #     #   bindd = , C, CLIPBOARD, exec, $clipboardHistoryQuery & $resetSubmap
    #     #
    #     # # Utility
    #     #   bindd = , P, PRINT-SCREEN, exec, grim -g "$(slurp)" - | swappy -f - | wl-copy & $resetSubmap
    #     #   bindd = , C, COLOR PICKER, exec, hyprpicker -a & $resetSubmap
    #     #   bindd = , R, SPEED READER, exec, $terminal bash ~/.config/hypr/speed-read.sh & $resetSubmap
    #     #   bindd = , E, EMOJI PICKER, exec, rofimoji --selector tofi & $resetSubmap
    #     #   bindd = , Y, AI YAP SESH, exec, astal toggleHAL & $resetSubmap
    #     #
    #     # # System
    #     #   bindd = , R, RELOAD SHELL, exec, ags quit; ags run & hyprctl reload & $resetSubmap & sleep 3 && hyprctl seterror disable
    #     #   bindd = , Z, TOGGLE ZEN MODE, exec, astal zenable & $resetSubmap # toggle zen mode
    #     #
    #     #   # Power menu
    #     #     bindd = , Q, SHUT DOWN, exec, sudo shutdown -h now
    #     #     bindd = , R, SHUT DOWN, exec, sudo shutdown -r now
    #     #
    #     #   # Audio
    #     #     binddl = , P, PLAY/PAUSE, exec, playerctl play-pause & $resetSubmap
    #     #     binddl = , L, NEXT, exec, playerctl next & $resetSubmap
    #     #     binddl = , H, PREVIOUS, exec, playerctl previous & $resetSubmap
    #     #
    #     #     binddle = , SM, MUTE/UNMUTE OUT, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle & $resetSubmap
    #     #     bindd = , MM, MUTE/UNMUTE IN, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle & $resetSubmap
    #     #
    #     #     bindd = , S, AUDIO SETTINGS, exec, easyeffects & $resetSubmap # TODO: replace wiwth AGS later
    #     #
    #     #   # Display
    #     #     binddle = , K, BRIGHTNESS UP, exec, brightnessctl set +10% & $resetSubmap
    #     #     binddle = , J, BRIGHTNESS DOWN, exec, brightnessctl set 10%- & $resetSubmap
    #
    #     mode.run.binding = {
    #       "esc" = "mode main";
    #
    #       "t" = "exec-and-forget open -na $TERMINAL";
    #     };
    #     mode.browser.binding = {
    #       "esc" = "mode main";
    #
    #       # "d" = "'''exec-and-forget osascript -e 'tell application \\\"Zen\\\" to make new document at end of documents\ntell application \\\"Zen\\\" to activate' '''"; # Default
    #       # "z" = "'''exec-and-forget osascript -e 'tell application \\\"Zen\\\" to make new document at end of documents\ntell application \\\"Zen\\\" to activate' '''";
    #       # "s" = "'''exec-and-forget osascript -e 'tell application \\\"Safari\\\" to make new document at end of documents\ntell application \\\"Zen\\\" to activate' '''";
    #     };
    #     mode.directories.binding = {
    #       "esc" = "mode main";
    #     };
    #     mode.query.binding = {
    #       "esc" = "mode main";
    #     };
    #     mode.utility.binding = {
    #       "esc" = "mode main";
    #     };
    #
    #     mode.system.binding = {
    #       "esc" = "mode main";
    #
    #       "alt-p" = "mode powermenu";
    #       "alt-a" = "mode audio";
    #       "alt-d" = "mode display";
    #     };
    #     mode.powermenu.binding = {
    #       "esc" = "mode system";
    #     };
    #     mode.audio.binding = {
    #       "esc" = "mode system";
    #
    #       "alt-k" = "volume up";
    #       "alt-j" = "volume down";
    #     };
    #     mode.display.binding = {
    #       "esc" = "mode system";
    #     };
    #
    #     mode.main.binding = {
    #       "cmd-h" = []; # Disable "hide application"
    #       "cmd-alt-h" = []; # Disable "hide others"
    #       "alt-m" = "fullscreen";
    #       "alt-w" = "close";
    #
    #       "alt-r" = "mode run";
    #       "alt-b" = "mode browser";
    #       "alt-d" = "mode directories";
    #       "alt-q" = "mode query";
    #       "alt-u" = "mode utility";
    #       "alt-s" = "mode system";
    #
    #       "alt-h" = "focus left";
    #       "alt-j" = "focus down";
    #       "alt-k" = "focus up";
    #       "alt-l" = "focus right";
    #
    #       "alt-shift-h" = "move left";
    #       "alt-shift-j" = "move down";
    #       "alt-shift-k" = "move up";
    #       "alt-shift-l" = "move right";
    #
    #       "alt-shift-f" = "layout floating tiling";
    #
    #       "alt-ctrl-h" = "resize width -30";
    #       "alt-ctrl-j" = "resize height +30";
    #       "alt-ctrl-k" = "resize height -30";
    #       "alt-ctrl-l" = "resize width +30";
    #
    #       "alt-1" = "workspace 1";
    #       "alt-2" = "workspace 2";
    #       "alt-3" = "workspace 3";
    #       "alt-4" = "workspace 4";
    #       "alt-5" = "workspace 5";
    #       "alt-6" = "workspace 6";
    #       "alt-7" = "workspace 7";
    #       "alt-8" = "workspace 8";
    #       "alt-9" = "workspace 9";
    #       "alt-0" = "workspace 10";
    #
    #       "alt-shift-1" = ["move-node-to-workspace 1" "workspace 1"];
    #       "alt-shift-2" = ["move-node-to-workspace 2" "workspace 2"];
    #       "alt-shift-3" = ["move-node-to-workspace 3" "workspace 3"];
    #       "alt-shift-4" = ["move-node-to-workspace 4" "workspace 4"];
    #       "alt-shift-5" = ["move-node-to-workspace 5" "workspace 5"];
    #
    #       "alt-shift-c" = "reload-config";
    #     };
    #   };
    # };
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

      NSGlobalDomain.NSWindowShouldDragOnGesture = true; # ctrl + cmd + drag = drag windows

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
