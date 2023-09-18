#
#  General Home-manager configuration
#

{ pkgs, os-channel, ... }:

{
  home = {
    packages = with pkgs; [
      # System
      ack
      glib
      htop
      fzf

      # File management
      rsync
      unzip
      unrar
      zip
    ];

    stateVersion = os-channel;
  };

  xdg.enable = true;

  programs = {
    home-manager.enable = true;
  };
}

