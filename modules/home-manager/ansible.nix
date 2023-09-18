#
# Ansible - Provisioning
#
{ config, lib, pkgs, ... }: with lib;
let
  cfg = config.modules.ansible;
in
{
  options.modules.ansible = { enable = mkEnableOption "ansible"; };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      unstable.ansible
      unstable.ansible-lint
    ];
  };
}
