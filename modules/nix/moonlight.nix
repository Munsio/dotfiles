#
# Moonlight - Game streaming
#

{ config, lib, pkgs, ... }: with lib;
let
  cfg = config.modules.moonlight;
in
{
  options.modules.moonlight = { enable = mkEnableOption "moonlight"; };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      moonlight-qt
    ];
  };
}
