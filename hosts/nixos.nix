{ self, inputs }:
let
  lib = inputs.nixpkgs.lib;
in
lib.mapAttrs
  (hostName: { mainUser, system, ... } @ hostInformation: lib.nixosSystem {
    modules = [
      (./. + "/${mainUser}@${hostName}")
      ../modules/nixos-core.nix
      {
        nixpkgs = {
          overlays = [ inputs.neovim-nightly-overlay.overlay ];
          config = {
            allowUnfree = true;
          };
        };
        nix.registry.nixpkgs.flake = inputs.nixpkgs;
        home-manager.extraSpecialArgs = {
          inherit (inputs) stylix;
        };
      }
    ];
    specialArgs = {
      inherit
        hostInformation
        hostName;

      inherit (inputs)
        home-manager
        nur
        agenix
        nix-index-database
        stylix
        nixos-hardware;
    };
  })
  (lib.attrsets.filterAttrs (_: v: v.type == "nixos") self.hosts)
