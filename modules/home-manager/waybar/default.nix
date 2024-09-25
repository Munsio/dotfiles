#
# Waybar - Bar widget
#
{ config, lib, ... }: with lib;
let
  cfg = config.modules.waybar;
in
{
  options.modules.waybar = { enable = mkEnableOption "waybar"; };

  config = mkIf cfg.enable {
    programs = {
			waybar = {
				enable = true;
			};
    };

    xdg.configFile.waybar = {
      enable = true;
      source = config.lib.meta.mkMutableSymlink ./config;
      target = "waybar";
    };
  };
}
