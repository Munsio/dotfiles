#
# Fish - Shell
#
{ config, lib, ... }: with lib;
let
  cfg = config.modules.fish;
in
{
  options.modules.fish = { enable = mkEnableOption "fish"; };

  config = mkIf cfg.enable {
    programs.fish = {
      enable = true;
			interactiveShellInit = ''
				set fish_greeting # Disable greeting
	    '';
    };
  };
}
