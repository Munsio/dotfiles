#
# AGS - Widgets
#

{ inputs, config, lib, pkgs, ... }: with lib;
let
  cfg = config.modules.ags;
in
{
  imports = [
    inputs.ags.homeManagerModules.default
  ];

  options.modules.ags = { enable = mkEnableOption "ags"; };

  config = mkIf cfg.enable {
    programs = {
      ags = {
        enable = true;
        extraPackages = with pkgs; [
          gtksourceview
          webkitgtk
          accountsservice
        ];
      };
    };

		xdg.configFile.ags = {
			enable = true;
	    source = config.lib.meta.mkMutableSymlink ./config;
		  target = "ags";
		};

		home = {
			packages = [
        pkgs.bun
        pkgs.sassc
      ];
    };
  };
}
