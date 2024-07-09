#
# This file includes the imports to all nix system packages
#
{ ... }: {

  imports = [
    ./greetd.nix
    ./hyprland.nix
    ./moonlight.nix
    ./nh.nix
  ];

}
