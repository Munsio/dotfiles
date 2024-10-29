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
    ags.enable = false;
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
        #"eDP-1,disable"
        #"desc:Iiyama North America PL2730H 1153603502279,1920x1080@60,0x0,1"
        #"desc:AOC U34G2G1 0x00001BA3,3440x1440@99.98,-760x1080,1"
        #"desc:AOC U34G2G1 0x00001BA3,highrr,-760x1080,1"
      ];
    };
    hyprlock.enable = true;
		hyprpanel.enable = true;
    hyprpaper.enable = true;
		kanshi.enable = true;
    kubernetes.enable = true;
    mako.enable = true;
    obsidian.enable = true;
    pywal.enable = true;
    rofi.enable = true;
    starship.enable = true;
    vscode.enable = true;
    discord.enable = true;
    nvim.enable = true;
		waybar.enable = false;
    wezterm.enable = true;
    yazi.enable = true;
  };
}
