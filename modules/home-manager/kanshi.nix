#
# Kanshi - Monitor config swapper
#
{ config, lib, pkgs, ... }: with lib;
let
  cfg = config.modules.kanshi;
in
{
  options.modules.kanshi = { enable = mkEnableOption "kanshi"; };

  config = mkIf cfg.enable {
		home.packages = with pkgs; [
			kanshi
		];
		
		services.kanshi = {
			enable = true;
			package = pkgs.kanshi;
			systemdTarget = "hyprland-session.target";

			settings = [
			  {
					profile.name = "undocked"; 
					profile.outputs = [
						{
							criteria = "eDP-1";
							scale = 1.0;
							status = "enable";
						}
					];
				}
				{
					profile.name = "desk";
					profile.outputs = [
						{
							criteria = "AOC U34G2G1 0x00001BA3";
							mode = "3440x1440@99.98";
							position = "-760,1080";
							scale = 1.0;
						}
						{
							criteria = "Iiyama North America PL2730H 1153603502279";
							mode = "1920x1080@60";
							position = "0,0";
							scale = 1.0;
						}
						{
							criteria = "eDP-1";
							status = "disable";
						}
					];
				}
			];
		};
  };
}
