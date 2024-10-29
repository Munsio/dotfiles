#
# Hyprland - Hyprland Desktop configuration
#

{ config, lib, pkgs, ... }: with lib;
let
  cfg = config.modules.hyprland;
in
{
  options.modules.hyprland = {
    enable = mkEnableOption "hyprland";
    monitor = mkOption {
      type = (types.listOf types.str);
    };
  };

  config = mkIf cfg.enable {
    wayland.windowManager.hyprland = {
      enable = true;
			systemd.enable = true;

      settings = {
        # Variables
        "$mod" = "SUPER";
        "$terminal" = config.home.sessionVariables.TERMINAL;
        # Monitor orientation
        monitor = cfg.monitor;
        # General
        general = {
          gaps_in = 10;
          gaps_out = 10;
        };
        # Decoration
        decoration = {
          rounding = 10;
        };
        # Dwindle
        dwindle = {
          pseudotile = true;
          preserve_split = true;
        };
        # Keyboard
        input = {
          kb_layout = "at";
        };
        misc = {
          disable_hyprland_logo = true;
        };
        windowrule = [
          "animation none, Rofi"
        ];
        exec-once = [
          "hypridle"
          "ags"
          "sleep 2; randomWallpaper" # Wait until hyprpaper is fully loaded
        ];
        # Bindings
        bind = [
          # Program bindings
          "$mod, RETURN, exec, $terminal"
          "$mod SHIFT, W, exec, randomWallpaper"
          "$mod, L, exec, killall rofi || rofi -show power-menu"
          "ALT, Space, exec, killall rofi || rofi -show drun"
          "$mod SHIFT, E, exec, kill $(pidof ags) || ags"
          "$mod CTRL, P, exec, toggleSonyHeadphones"

          # General window/behaviour binding
          "$mod, Q, killactive,"
          "$mod, F, togglefloating, "
          "$mod, P, pseudo, # dwindle"
          "$mod, J, togglesplit, # dwindle"

          # Move focus with $mod + arrow keys
          "$mod, left, movefocus, l"
          "$mod, right, movefocus, r"
          "$mod, up, movefocus, u"
          "$mod, down, movefocus, d"

          # Workspace special mods
          "$mod SHIFT, right, movetoworkspace, e+1"
          "$mod SHIFT, left, movetoworkspace, e-1"

          # Scroll through existing workspaces with $mod + scroll
          "$mod, mouse_down, workspace, e+1"
          "$mod, mouse_up, workspace, e-1"
          "$mod CTRL, right, workspace, e+1 "
          "$mod CTRL, left, workspace, e-1"
        ] ++ (
          # workspaces
          # binds $mod + [shift +] {1..10} to [move to] workspace {1..10}
          builtins.concatLists (builtins.genList
            (
              x:
              let
                ws =
                  let
                    c = (x + 1) / 10;
                  in
                  builtins.toString (x + 1 - (c * 10));
              in
              [
                "$mod, ${ws}, workspace, ${toString (x + 1)}"
                "$mod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
              ]
            )
            10)
        );

        # Media Keys
        bindl = [
          ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
          ", XF86AudioPlay, exec, playerctl play-pause" # the stupid key is called play , but it toggles 
          ", XF86AudioNext, exec, playerctl next"
          ", XF86AudioPrev, exec, playerctl previous"
        ];

        # Volume Keys
        bindel = [
          ", XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
          ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ];

        # Mouse bindings
        bindm = [
          "$mod, mouse:272, movewindow"
          "$mod, mouse:273, resizewindow"
        ];
      };
      systemd.variables = [ "--all" ];
    };
  };
}
