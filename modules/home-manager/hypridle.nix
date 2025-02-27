#
# Hypridle - Idle Dameon
#

{ config, lib, pkgs, ... }: with lib;
let
  cfg = config.modules.hypridle;
in
{
  options.modules.hypridle = { enable = mkEnableOption "hypridle"; };

  config = mkIf cfg.enable {
    services.hypridle = {
      enable = true;
      package = pkgs.hypridle;
      settings = {
        general = {
          lock_cmd = "pidof hyprlock || hyprlock";
          before_sleep_cmd = "loginctl lock-session";
          after_sleep_cmd = "hyprctl dispatch dpms on";
        };

				listener = [
					{
				    timeout = 150;                                # 2.5min.
				    on-timeout = "brightnessctl -s set 10";         # set monitor backlight to minimum, avoid 0 on OLED monitor.
				    on-resume = "brightnessctl -r";                 # monitor backlight restor.
					}
					{
						timeout = 900;                                 # 15min
						on-timeout = "loginctl lock-session";            # lock screen when timeout has passed
					}
					{
						timeout = 1200;                                 # 20min
						on-timeout = "hyprctl dispatch dpms off";        # screen off when timeout has passed
						on-resume = "hyprctl dispatch dpms on";          # screen on when activity is detected after timeout has fired.
					}
					{
						timeout = 1800;                                # 30min
						on-timeout = "systemctl suspend";                # suspend pc
					}
				];
      };
    };
  };
}
