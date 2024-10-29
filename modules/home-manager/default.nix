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
		./hyprpanel.nix
    ./hyprpaper.nix
		./kanshi.nix
    ./kubernetes.nix
    ./mako.nix
    ./nvim
    ./obsidian.nix
    ./pywal
    ./rofi.nix
    ./starship.nix
    ./vscode.nix
		./waybar
    ./wezterm/wezterm.nix
    ./yazi.nix
  ];

}
