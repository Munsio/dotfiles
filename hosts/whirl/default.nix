#
#  Specific system configuration settings for Vortex
#
#  Included from ~/.setup/hosts/default.nix

{ inputs, outputs, pkgs, ... }:

{
  imports = [
    inputs.nixos-hardware.nixosModules.common-gpu-intel-kaby-lake
    ./hardware-configuration.nix

    outputs.nixosModules
    ../../user/martin
  ];

  # Enable host specific modules
  modules = {
    greetd.enable = true;
    hyprland.enable = true;
    moonlight.enable = true;
  };

  boot = {
    #kernelPackages = pkgs.linuxPackages_latest; # Latest kernel

    initrd.luks.devices."luks-e561fade-91e3-4e86-aa7f-36a4a6bb68ca".device = "/dev/disk/by-uuid/e561fade-91e3-4e86-aa7f-36a4a6bb68ca";

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
}
