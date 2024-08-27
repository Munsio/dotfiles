#
#  Home-manager configuration for User "martin"
#

{ ... }:
let

in
{
  imports = [
    ../common.nix
  ];

  home = {
    username = "martin";
    homeDirectory = "/home/martin";

    sessionVariables = {
      TERMINAL = "wezterm";
      EDITOR = "vim";
    };
  };
}
