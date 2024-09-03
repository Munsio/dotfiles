#
# eww - Widgets (Statusbar)
#
{ config, lib, pkgs, ... }: with lib;
let
  cfg = config.modules.eww;

  ewwStart = pkgs.writeShellScriptBin "ewwStart" ''
    # kill any running instances if they exist
    eww kill

    # start a bar for each monitor
    monitors=$(hyprctl monitors -j | jq '.[] | .id')

    for monitor in ''${monitors}; do
        eww open bar''${monitor}
    done
  '';
in
{
  options.modules.eww = { enable = mkEnableOption "eww"; };

  config = mkIf cfg.enable {
    programs.eww = {
      enable = true;
      configDir = ./config;
    };

    home.packages = with pkgs; [
      jq
      socat
      ewwStart
    ];
  };
}
