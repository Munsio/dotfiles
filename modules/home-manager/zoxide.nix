#
# Fish - Shell
#
{ config, lib, ... }: with lib;
let
  cfg = config.modules.zoxide;
in
{
  options.modules.zoxide = { enable = mkEnableOption "zoxide"; };

  config = mkIf cfg.enable {
    programs.zoxide = {
      enable = true;
			enableFishIntegration = true;
    };
  };
}
