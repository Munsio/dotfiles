#
# Yazi - Terminal filebrowser
#
{ config, lib, pkgs, ... }: with lib;
let
  cfg = config.modules.yazi;
in
{
  options.modules.yazi = { enable = mkEnableOption "yazi"; };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      unstable.yazi
    ];
  };
}
