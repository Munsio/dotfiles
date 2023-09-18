#
# Hyprland - Tiling Window Manager
#

{ config, lib, ... }: with lib;
let
  cfg = config.modules.hyprland;
in
{
  options.modules.hyprland = {
    enable = mkEnableOption "hyprland";
  };

  config = mkIf cfg.enable {
    programs.hyprland.enable = true;
  };
}
