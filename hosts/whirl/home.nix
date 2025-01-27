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
		fish.enable = true;
		hyprpanel.enable = true;
		kanshi.enable = true;
		zoxide.enable = true;
    discord.enable = true;
    firefox.enable = true;
    git-autofixup.enable = true;
    git.enable = true;
    go.enable = true;
    hugo.enable = true;
    hypridle.enable = true;
    hyprland.enable = true;
    hyprlock.enable = true;
    hyprpaper.enable = true;
    kubernetes.enable = true;
    mako.enable = true;
    nvim.enable = true;
    obsidian.enable = true;
    pywal.enable = true;
    rofi.enable = true;
    starship.enable = true;
    vscode.enable = true;
    wezterm.enable = true;
    yazi.enable = true;
  };
}
