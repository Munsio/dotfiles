#
#  NixOS configuration definition for hosts
#
#  Included from ~/.setup/flake.nix

{ inputs, outputs, os-channel, ... }:

let
  lib = inputs.nixpkgs.lib;
in
{
  # OS Configuration for system "Vortex"
  vortex = lib.nixosSystem {
    specialArgs = {
      inherit inputs outputs os-channel;
    }; # Pass flake variable
    modules = [
      # Modules that are used.
      ./common.nix
      ./vortex

      inputs.home-manager.nixosModules.home-manager
      {
        # Home-Manager module that is used.
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = {
          inherit inputs outputs os-channel;
        }; # Pass flake variable
        home-manager.users.martin = {
          imports = [
            ./vortex/home.nix
            ../user/martin/home.nix
          ];
        };
      }
    ];
  };

  whirl = lib.nixosSystem {
    specialArgs = {
      inherit inputs outputs os-channel;
    }; # Pass flake variable
    modules = [
      # Modules that are used.
      ./common.nix
      ./whirl

      inputs.home-manager.nixosModules.home-manager
      {
        # Home-Manager module that is used.
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = {
          inherit inputs outputs os-channel;
        }; # Pass flake variable
        home-manager.users.martin = {
          imports = [
            ./whirl/home.nix
            ../user/martin/home.nix
          ];
        };
      }
    ];
  };
}
