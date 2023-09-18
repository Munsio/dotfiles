#
# Git-Autofixup - Autofixup changes in git commits
#

{ config, lib, pkgs, ... }: with lib;
let
  cfg = config.modules.git-autofixup;
in
{
  options.modules.git-autofixup = {
    enable = mkEnableOption "git-autofixup";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs;[
      git-autofixup
    ];
  };
}
