#
#  Home-manager configuration for Vortex
#
#  Included from ~/.setup/hosts/default.nix

{ outputs, ... }:

{
  imports = [
    # Load Home-Manager modules
    outputs.homeManagerModules

    # Theme
    ../../modules/themes/nord/home.nix
  ];

  # Enable Modules
  modules = {
    ags.enable = true;
    alacritty.enable = true;
    ansible.enable = true;
    firefox.enable = true;
    fish.enable = true;
    git-autofixup.enable = true;
    git.enable = true;
    go.enable = true;
    hugo.enable = true;
    hypridle.enable = true;
    hyprland = {
      enable = true;
      monitor = [
        "DP-1,1920x1080@60,0x0,1"
        "HDMI-A-1,3440x1440@100,-760x1080,1"
      ];
    };
    hyprlock.enable = true;
    hyprpaper.enable = true;
    kubernetes.enable = true;
    mako.enable = true;
    obsidian.enable = true;
    pywal.enable = true;
    rofi.enable = true;
    starship.enable = true;
    vscode.enable = true;
  };
}
