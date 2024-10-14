#
# Git - Version control
#
{ config, lib, pkgs, ... }: with lib;
let
  cfg = config.modules.git;
in
{
  options.modules.git = { enable = mkEnableOption "git"; };

  config = mkIf cfg.enable {
		home.packages = with pkgs; [
			lazygit
		];

    programs = {
      git = {
        enable = true;
        aliases = {
          a = "add";
          c = "commit";
          ca = "commit --amend";
          f = "fixup";
          fa = "fetch --all";
          fixup = "!git log -n 50 --pretty=format:'%h %s' --no-merges | fzf | cut -c -7 | xargs -o -I % sh -c 'git commit --fixup % && git rebase -i %^'";
          l = "log --pretty=format:\"%h - %an:%x09%s\"";
          pf = "push --force";
          ra = "rebase --abort";
          rc = "rebase --continue";
          ri = "!git log -n 50 --pretty=format:'%h %s' --no-merges | fzf | cut -c -7 | xargs -o -I % sh -c 'git rebase -i %^'";
          s = "status";
        };
        extraConfig = {
          push = {
            autoSetupRemote = true;
          };
          rebase = {
            autosquash = true;
          };
          rerere = {
            enabled = true;
          };
        };
      };
    };
  };
}
