#
# This file includes the imports to all nix system packages
#
{ ... }: {

  imports = [
    ./greetd.nix
    ./nh.nix
    ./hyprland.nix
  ];

}
