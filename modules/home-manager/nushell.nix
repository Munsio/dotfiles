#
#  Nushell - Home Manager
#
{ config, lib, pkgs, ... }: with lib;
let
  cfg = config.modules.nushell;
in
{
  options.modules.nushell = { enable = mkEnableOption "nushell"; };

  config = mkIf cfg.enable {
    programs = {
      nushell = {
        enable = true;

				extraConfig = ''
				 let carapace_completer = {|spans|
				 carapace $spans.0 nushell $spans | from json
				 }
				 $env.config = {
					show_banner: false,
					completions: {
					case_sensitive: false # case-sensitive completions
					quick: true    # set to false to prevent auto-selecting completions
					partial: true    # set to false to prevent partial filling of the prompt
					algorithm: "fuzzy"    # prefix or fuzzy
					external: {
					# set to false to prevent nushell looking into $env.PATH to find more suggestions
							enable: true 
					# set to lower can improve completion performance at the cost of omitting some options
							max_results: 100 
							completer: $carapace_completer # check 'carapace_completer' 
						}
					}
				 } 
				 $env.PATH = ($env.PATH | 
				 split row (char esep) |
				 prepend /home/myuser/.apps |
				 append /usr/bin/env
				 )
				'';

				shellAliases = {
					os-update = "nh os switch -u -a";
				};
			};
			carapace = {
				enable = true;
				enableNushellIntegration = true;
			};

      # As Nushell is not POSIX complient we hack the "default" shell - https://nixos.wiki/wiki/Fish#Setting_nushell_as_your_shell
      zsh = {
        initExtraFirst = lib.mkForce ''
          if [[ $(${pkgs.procps}/bin/ps --no-header --pid=$PPID --format=comm) != "nushell" && -z ''${BASH_EXECUTION_STRING} ]]
          then
            [[ -o login ]] && LOGIN_OPTION='--login' || LOGIN_OPTION=""
            exec ${pkgs.nushell}/bin/nu $LOGIN_OPTION
          fi
        '';
      };
      bash = {
        enable = true;
        initExtra = lib.mkForce ''
          if [[ $(${pkgs.procps}/bin/ps --no-header --pid=$PPID --format=comm) != "nushell" && -z ''${BASH_EXECUTION_STRING} ]]
          then
            shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=""
            exec ${pkgs.nushell}/bin/nu $LOGIN_OPTION
          fi
        '';
      };

    };
	};
}
