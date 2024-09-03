#
# Pywal - Extract colors from Wallpapers
#

{ config, lib, ... }: with lib;
let
  cfg = config.modules.pywal;
in
{
  options.modules.pywal = { enable = mkEnableOption "pywal"; };

  config = mkIf cfg.enable {
    programs = {
      pywal.enable = true;

      alacritty.settings = {
        import = [
          "~/.cache/wal/colors-alacritty.toml"
        ];
      };
    };

    wayland.windowManager.hyprland.settings = {
      source = [
        "~/.cache/wal/colors-hyprland.conf"
      ];
    };

    # Sync wal templates to config folder
    home.file."pywal" = {
      source = ./config;
      target = ".config/wal/";
      recursive = true;
    };
  };
}
