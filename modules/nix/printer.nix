#
# printer - NixOS Printing
#
{ config, lib, ... }: with lib;
let
  cfg = config.modules.printer;
in
{
  options.modules.printer = { enable = mkEnableOption "printer"; };

  config = mkIf cfg.enable {
		services = {
			printing = {
				enable = true;
				browsed.enable = false;
			};

			avahi = {
				enable = true;
				nssmdns4 = true;
				openFirewall = true;
			};
		};
  };
}
