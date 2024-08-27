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
      direnv
      killall
      nixpkgs-fmt
      pciutils
      sops
      unstable.nixd
      usbutils
      vim
      wget
    ];
  };

  # Programs
  programs = {
    command-not-found.enable = false;
  };

  # USB automount
  services.devmon.enable = true;
  services.gvfs.enable = true;
  services.udisks2.enable = true;

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
      outputs.overlays.flake-wezterm
      inputs.nix-vscode-extensions.overlays.default
    ];
    config.allowUnfree = true;
  };

  system.stateVersion = os-channel;

  # Auto installing firmware which is allowed to be redistributed.
  hardware.enableRedistributableFirmware = lib.mkDefault true;
}
