#
# Alacritty - Terminal
#
{ config, lib, ... }: with lib;
let
  cfg = config.modules.alacritty;
in
{
  options.modules.alacritty = { enable = mkEnableOption "alacritty"; };

  config = mkIf cfg.enable {
    programs = {
      alacritty = {
        enable = true;
        settings = {
          env = {
            "TERM" = "xterm-256color";
          };

          font = {
            normal = {
              family = "Fira Code Light";
              style = "regular";
            };
          };

          window = {
            padding = {
              x = 10;
              y = 10;
            };
          };

          keyboard.bindings = [
            {
              key = "K";
              mods = "Control|Shift";
              action = "ClearHistory";
            }
          ];
        };
      };
    };
  };
}
