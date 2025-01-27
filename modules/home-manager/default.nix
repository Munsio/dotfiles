#
# This file includes the imports to all home-manager modules
#
{ ... }: {

  imports = [
		./fish.nix
		./hyprpanel.nix
		./kanshi.nix
		./zoxide.nix
    ./discord.nix
    ./firefox.nix
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
    ./nvim
    ./obsidian.nix
    ./pywal
    ./rofi.nix
    ./starship.nix
    ./vscode.nix
    ./wezterm/wezterm.nix
    ./yazi.nix
  ];

}
