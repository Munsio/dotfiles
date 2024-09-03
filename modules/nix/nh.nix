#
# nh - NixOS Helper Script
#
{ config, lib, pkgs, ... }: with lib;
let
  cfg = config.modules.nh;
in
{
  options.modules.nh = { enable = mkEnableOption "nh"; };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      nix-output-monitor
      nvd
    ];

    programs = {
      nh = {
        enable = true;
        clean.enable = true;
        clean.extraArgs = "--keep-since 4d --keep 5";
      };
    };
  };
}
