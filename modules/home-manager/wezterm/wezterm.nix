#
# Wezterm - Rust terminal
#

{ config, lib, pkgs, ... }: with lib;
let
  cfg = config.modules.wezterm;
in
{
  options.modules.wezterm = { enable = mkEnableOption "wezterm"; };

  config = mkIf cfg.enable {
    programs.wezterm = {
      enable = true;
      extraConfig = builtins.readFile ./wezterm.lua;
    };
  };
}
