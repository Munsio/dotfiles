#
#  Fish - Home Manager
#
{ config, lib, pkgs, ... }: with lib;
let
  cfg = config.modules.fish;
in
{
  options.modules.fish = { enable = mkEnableOption "fish"; };

  config = mkIf cfg.enable {
    programs = {
      fish = {
        enable = true;

        shellInit = ''
          set fish_greeting

          # Hook direnv
          direnv hook fish | source
        '';

        shellAliases = {
          os-update = "nh os switch -u -a";
        };
      };

      # As Fish is not POSIX complient we hack the "default" shell - https://nixos.wiki/wiki/Fish#Setting_fish_as_your_shell
      zsh = {
        initExtraFirst = lib.mkForce ''
          if [[ $(${pkgs.procps}/bin/ps --no-header --pid=$PPID --format=comm) != "fish" && -z ''${BASH_EXECUTION_STRING} ]]
          then
            [[ -o login ]] && LOGIN_OPTION='--login' || LOGIN_OPTION=""
            exec ${pkgs.fish}/bin/fish $LOGIN_OPTION
          fi
        '';
      };
      bash = {
        enable = true;
        initExtra = lib.mkForce ''
          if [[ $(${pkgs.procps}/bin/ps --no-header --pid=$PPID --format=comm) != "fish" && -z ''${BASH_EXECUTION_STRING} ]]
          then
            shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=""
            exec ${pkgs.fish}/bin/fish $LOGIN_OPTION
          fi
        '';
      };

    };
  };
}
