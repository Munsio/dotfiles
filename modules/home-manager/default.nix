#
# This file includes the imports to all home-manager modules
#
{ ... }: {

  imports = [
    ./ags
    ./alacritty.nix
    ./ansible.nix
    ./discord.nix
    ./eww
    ./firefox.nix
    ./fish.nix
    ./git-autofixup.nix
    ./git.nix
    ./go.nix
    ./hugo.nix
    ./hypridle.nix
    ./hyprland.nix
    ./hyprlock.nix
    ./hyprpaper.nix
    ./kubernetes.nix
    ./mako.nix
    ./obsidian.nix
    ./pywal
    ./rofi.nix
    ./starship.nix
    ./vscode.nix
  ];

}
