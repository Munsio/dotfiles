#
#  Main NixOS configuration for all hosts
#
#  Included from ~/.setup/hosts/default.nix

{ inputs, outputs, lib, pkgs, os-channel, ... }:

{
  imports = [
    outputs.nixosModules
  ];

  # Default modules
  modules = {
    nh.enable = true;
  };

  # Timezone
  time.timeZone = "Europe/Vienna";
  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "de_AT.UTF-8";
      LC_IDENTIFICATION = "de_AT.UTF-8";
      LC_MEASUREMENT = "de_AT.UTF-8";
      LC_MONETARY = "de_AT.UTF-8";
      LC_NAME = "de_AT.UTF-8";
      LC_NUMERIC = "de_AT.UTF-8";
      LC_PAPER = "de_AT.UTF-8";
      LC_TELEPHONE = "de_AT.UTF-8";
      LC_TIME = "de_AT.UTF-8";
    };
  };

  # Console
  console = {
    keyMap = lib.mkDefault "de";
  };

  # Security
  security = {
    rtkit.enable = true;
    polkit.enable = true;
  };

  # Environment and standard packages
  environment = {
    systemPackages = with pkgs; [
      killall
      pciutils
      usbutils
      vim
      wget
      nixd
      nixpkgs-fmt
      direnv
    ];
  };

  # Nix configuration
  nix = {
    settings = {
      auto-optimise-store = true;
    };
    registry.nixpkgs.flake = inputs.nixpkgs;
    extraOptions = ''
      experimental-features = nix-command flakes
      keep-outputs          = true
      keep-derivations      = true
    '';
  };

  # Register overlays and allow nonfree packages
  nixpkgs = {
    overlays = [
      outputs.overlays.unstable-packages
    ];
    config.allowUnfree = true;
  };

  system.stateVersion = os-channel;

  # Auto installing firmware which is allowed to be redistributed.
  hardware.enableRedistributableFirmware = lib.mkDefault true;
}
