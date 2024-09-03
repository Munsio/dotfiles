#
#  Home-manager configuration for User "martin"
#

{ config, lib, ... }: with lib;
let

in
{
  imports = [

    ../common.nix
  ];


  programs = {
    git = mkIf config.modules.git.enable {
      userEmail = "martin@treml.dev";
      userName = "Martin Treml";
    };
  };

  home = {
    username = "martin";
    homeDirectory = "/home/martin";

    sessionVariables = {
      TERMINAL = "wezterm";
      EDITOR = "vim";
    };
  };


}
