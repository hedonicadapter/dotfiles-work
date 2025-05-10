{pkgs, ...}: let
  karabinerConfig = ''
  '';
in {
  home.packages = with pkgs; [
    karabiner-elements
  ];

  # home.file."~/.config/karabiner/karabiner.json".text = karabinerConfig;
}
