#
# Kubernetes - Kubernetes environment
#
{ config, lib, pkgs, ... }: with lib;
let
  cfg = config.modules.kubernetes;
in
{
  options.modules.kubernetes = { enable = mkEnableOption "kubernetes"; };

  config = mkIf cfg.enable {
    home = {
      packages = with pkgs; [
        kubectl
        kubernetes-helm
      ];
    };

    programs = {
      k9s = {
        enable = true;
        package = pkgs.unstable.k9s;
      };
    };
  };
}
