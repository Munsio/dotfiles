#
# Obsidian - Second Markdown Brain
#
{ config, lib, pkgs, ... }: with lib;
let
  cfg = config.modules.obsidian;
in
{
  options.modules.obsidian = { enable = mkEnableOption "obsidian"; };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      unstable.obsidian
    ];
  };
}
