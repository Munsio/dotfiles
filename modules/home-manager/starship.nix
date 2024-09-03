#
# Starship - A new prompt
#
{ config, lib, ... }: with lib;
let
  cfg = config.modules.starship;
in
{
  options.modules.starship = { enable = mkEnableOption "starship"; };

  config = mkIf cfg.enable {
    programs = {
      starship = {
        enable = true;
        enableFishIntegration = true;
        settings = {
          add_newline = false;
          format = lib.concatStrings [
            "$directory"
            "$character"
          ];
          right_format = "$all";

          git_branch = {
            format = "[$symbol$branch(:$remote_branch)]($style) ";
          };

          golang = {
            symbol = " ";
          };
        };
      };
    };
  };
}
