#
# Firefox - Web Browser
#
{ config, lib, pkgs, ... }: with lib;
let
  cfg = config.modules.firefox;
in
{
  options.modules.firefox = { enable = mkEnableOption "firefox"; };

  config = mkIf cfg.enable {
    programs.firefox = {
      enable = true;
      package = pkgs.unstable.firefox;
    };
  };
}
