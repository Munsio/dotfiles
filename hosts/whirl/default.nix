#
#  Specific system configuration settings for Vortex
#
#  Included from ~/.setup/hosts/default.nix

{ inputs, outputs, pkgs, ... }:

{
  imports = [
    inputs.nixos-hardware.nixosModules.framework-13-7040-amd
    ./hardware-configuration.nix

    outputs.nixosModules
    ../../user/martin
  ];

  # Enable host specific modules
  modules = {
    greetd.enable = true;
    hyprland.enable = true;
    moonlight.enable = true;
		printer.enable = true;
  };

  boot = {
    kernelPackages = pkgs.linuxPackages_6_11; # Latest kernel

    initrd.luks.devices."luks-c5ef7dea-9875-4d93-a0a4-b063c31d44e2".device = "/dev/disk/by-uuid/c5ef7dea-9875-4d93-a0a4-b063c31d44e2";

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
    hostName = "whirl";
  };

  # Override sudo timeout to ask for password again.
  security.sudo.extraConfig = ''
    Defaults        timestamp_timeout=15
  '';

  # Host specific special configuration
  #environment.variables.WLR_DRM_DEVICES = "/dev/dri/card1:/dev/dri/card0"; # GPU preference for hyprland

  # OVERRIDES
  programs.dconf.enable = true;

  services.blueman.enable = true;
}
