#
# Go - Development language
#
{ config, lib, pkgs, ... }: with lib;
let
  cfg = config.modules.go;
in
{
  options.modules.go = { enable = mkEnableOption "go"; };

  config = mkIf cfg.enable {
    programs.go = {
      enable = true;
      package = pkgs.unstable.go;
    };
  };
}
