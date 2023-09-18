#
#  Specific system configuration settings for Vortex
#
#  Included from ~/.setup/hosts/default.nix

{ outputs, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix

    outputs.nixosModules
    ../../user/martin
  ];

  # Enable host specific modules
  modules = {
    greetd.enable = true;
    hyprland.enable = true;
  };

  boot = {
    kernelPackages = pkgs.linuxPackages_latest; # Latest kernel

    loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 5;
      };
      efi = {
        canTouchEfiVariables = true;
      };
    };
  };

  networking = {
    networkmanager.enable = true;
    hostName = "vortex";
  };

  # Override sudo timeout to ask for password again.
  security.sudo.extraConfig = ''
    Defaults        timestamp_timeout=15
  '';

  # Host specific special configuration
  services.qemuGuest.enable = true;
  environment.variables.WLR_DRM_DEVICES = "/dev/dri/card1:/dev/dri/card0"; # GPU preference for hyprland

  # OVERRIDES
  programs.dconf.enable = true;
}
