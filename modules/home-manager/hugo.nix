#
# Hugo - Static site generator
#
{ config, lib, pkgs, ... }: with lib;
let
  cfg = config.modules.hugo;
in
{
  options.modules.hugo = { enable = mkEnableOption "hugo"; };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      unstable.hugo
    ];
  };
}
