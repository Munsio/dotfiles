#
# Rofi - DMenu Popup
#

{ config, lib, pkgs, ... }: with lib;
let
  cfg = config.modules.rofi;
in
{
  options.modules.rofi = { enable = mkEnableOption "rofi"; };

  config = mkIf cfg.enable {
    programs.rofi = {
      enable = true;
      package = pkgs.rofi-wayland;
      plugins = with pkgs; [
        (rofi-calc.override {
          rofi-unwrapped = rofi-wayland-unwrapped;
        })
        rofi-power-menu
      ];
      extraConfig = {
        modes = "power-menu:${pkgs.rofi-power-menu}/bin/rofi-power-menu";
        show-icons = true;
        icon-theme = "Zafiro-icons-Dark";
        display-drun = "Applications";
        display-window = "Windows";
        drun-display-format = "{name}";
        font = "Fira Code 11";
      };
    };
  };
}
