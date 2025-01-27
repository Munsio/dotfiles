#
# Hyprpaper - Wallpaper engine for Hyprland
#
{ config, lib, pkgs, ... }: with lib;
let
  cfg = config.modules.hyprpaper;

  pywal = if config.modules.pywal.enable then ''wal -i ''${papers[$random]}'' else "";

  randomWallpaper = pkgs.writeShellScriptBin "randomWallpaper" ''
    dir="$HOME/.config/wallpapers/" # The last / is important
    cd $dir

    # Get a list of the .png files in the directory.
    papers=("''${dir}"*.png)

    # Randomize one of the wallpapers
    length=''${#papers[@]}
    random=$((1 + $RANDOM % $length - 1))

    # Symlink random wallpaper in `.cache` folder
    extension="''${papers[$random]##*.}"
    ln -sf ''${papers[$random]} ~/.cache/current_wallpaper.$extension

    # Set random wallpaper
    hyprctl hyprpaper preload ''${papers[$random]}
    hyprctl hyprpaper wallpaper ",''${papers[$random]}"

    ${pywal}
  '';
in
{
  options.modules.hyprpaper = { enable = mkEnableOption "hyprpaper"; };

  config = mkIf cfg.enable {
    services.hyprpaper = {
      enable = true;
      package = pkgs.hyprpaper;
      settings = {
        ipc = true;
        splash = false;
      };
    };

    home.packages = [
      randomWallpaper
    ];
  };
}
