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
      };
    };
  };
}
