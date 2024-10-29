#
# Hyprpanel - AGS configured Panel & OSD
#
{ config, lib, pkgs, ... }: with lib;
let
  cfg = config.modules.hyprpanel;
in
{
  options.modules.hyprpanel = { enable = mkEnableOption "hyprpanel"; };

  config = mkIf cfg.enable {
		home.packages = with pkgs; [
			hyprpanel
		];
  };
}
