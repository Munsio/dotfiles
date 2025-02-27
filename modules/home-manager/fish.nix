#
# Fish - Shell
#
{ config, lib, pkgs, ... }: with lib;
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

		programs.bash = {
			enable = true;
			initExtra = ''
				if [[ $(${pkgs.procps}/bin/ps --no-header --pid=$PPID --format=comm) != "fish" && -z ''${BASH_EXECUTION_STRING} ]]
				then
					shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=""
					exec ${pkgs.fish}/bin/fish $LOGIN_OPTION
				fi
			'';
		};
  };
}
