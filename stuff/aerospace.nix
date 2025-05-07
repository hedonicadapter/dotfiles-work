{pkgs, ...}: let
  aerospaceConfig = ''
    after-login-command = ["layout tiles"]
    after-startup-command = []
    default-root-container-layout = "tiles"
    default-root-container-orientation = "auto"
    enable-normalization-flatten-containers = true
    enable-normalization-opposite-orientation-for-nested-containers = true
    exec-on-workspace-change = []
    on-focus-changed = ["move-mouse window-lazy-center"]
    on-focused-monitor-changed = ["move-mouse monitor-lazy-center"]
    on-window-detected = []
    start-at-login = true

    [exec.env-vars]
    TERMINAL = 'kitty'
    DEFAULT_BROWSER = 'zen'

    [gaps.inner]
    horizontal = [{ monitor.main = 18 }, 12]
    vertical = [{ monitor.main = 18 }, 12]

    [gaps.outer]
    bottom = [{ monitor.main = 42 }, 12]
    left = [{ monitor.main = 342 }, 12]
    right = [{ monitor.main = 342 }, 12]
    top = [{ monitor.main = 42 }, 12]

    [key-mapping]
    preset = "qwerty"

    [mode.main.binding]
    alt-1 = "workspace 1"
    alt-2 = "workspace 2"
    alt-3 = "workspace 3"
    alt-4 = "workspace 4"
    alt-5 = "workspace 5"
    alt-ctrl-h = "resize width -30"
    alt-ctrl-j = "resize height +30"
    alt-ctrl-k = "resize height -30"
    alt-ctrl-l = "resize width +30"
    alt-d = "mode directories"
    alt-h = "focus left"
    alt-j = "focus down"
    alt-k = "focus up"
    alt-l = "focus right"
    alt-m = "fullscreen"
    alt-shift-1 = ["move-node-to-workspace 1", "workspace 1"]
    alt-shift-2 = ["move-node-to-workspace 2", "workspace 2"]
    alt-shift-3 = ["move-node-to-workspace 3", "workspace 3"]
    alt-shift-4 = ["move-node-to-workspace 4", "workspace 4"]
    alt-shift-5 = ["move-node-to-workspace 5", "workspace 5"]
    alt-shift-r = "reload-config"
    alt-shift-f = "layout floating tiling"
    alt-shift-h = "move left"
    alt-shift-j = "move down"
    alt-shift-k = "move up"
    alt-shift-l = "move right"
    alt-w = "close --quit-if-last-window"
    cmd-alt-h = []
    cmd-h = []

    alt-u = "mode utility"
    alt-b = "mode browser"
    alt-q = "mode query"
    alt-r = "mode run"
    alt-s = "mode system"

    [mode.powermenu.binding]
    esc = "mode system"

    [mode.query.binding]
    esc = "mode main"

    [mode.run.binding]
    esc = "mode main"
    t = ["exec-and-forget open -na $TERMINAL", "mode main"]

    [mode.system.binding]
    a = "mode audio"
    d = "mode display"
    p = "mode powermenu"
    esc = "mode main"

    [mode.utility.binding]
    esc = "mode main"

    [mode.audio.binding]
    j = "volume down"
    k = "volume up"
    esc = "mode system"

    [mode.browser.binding]
    d = ["exec-and-forget open -na $DEFAULT_BROWSER", "mode main"]
    z = ["exec-and-forget open -na Zen", "mode main"]
    s = ["exec-and-forget open -na Safari", "mode main"]
    esc = "mode main"

    [mode.directories.binding]
    d = ["exec-and-forget open ~/Downloads", "mode main"]
    p = ["exec-and-forget open ~/Documents/projects", "mode main"]
    t = ["exec-and-forget open ~/.Trash", "mode main"]
    esc = "mode main"

    [mode.display.binding]
    esc = "mode system"

    [workspace-to-monitor-force-assignment]
  '';
in {
  home.packages = with pkgs; [
    aerospace
  ];
  home.file.".aerospace.toml".text = aerospaceConfig;
}
