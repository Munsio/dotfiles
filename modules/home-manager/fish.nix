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
			shellAliases = {
				os-update = "nh os switch -u -a";
				kanshi-reload = "systemctl --user restart kanshi.service";
			};
    };
  };
}
