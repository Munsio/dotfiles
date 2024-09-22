#
#  General Home-manager configuration
#

{ pkgs, os-channel, config, lib, inputs, ... }:

{

  lib.meta = {
    configPath = "${config.home.homeDirectory}/.setup";
    mkMutableSymlink = path: config.lib.file.mkOutOfStoreSymlink
      (config.lib.meta.configPath + lib.removePrefix (toString inputs.self) (toString path));
  };

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

