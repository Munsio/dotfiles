#
# This file includes the imports to all home-manager modules
#
{ ... }: {

  imports = [
    ./ags
    ./alacritty.nix
    ./eww
    ./firefox.nix
    ./fish.nix
    ./git.nix
    ./go.nix
    ./hypridle.nix
    ./hyprland.nix
    ./hyprlock.nix
    ./hyprpaper.nix
    ./kubernetes.nix
    ./mako.nix
    ./pywal
    ./rofi.nix
    ./starship.nix
    ./vscode.nix
    ./obsidian.nix
    ./hugo.nix
    ./ansible.nix
    ./git-autofixup.nix
  ];

}
