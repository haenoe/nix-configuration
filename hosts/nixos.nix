{ self, home-manager, inputs, nur, agenix, nixpkgs, nix-index-database }:
let
  lib = inputs.nixpkgs.lib;
in
lib.mapAttrs
  (hostName: { mainUser, ... } @ hostInformation: lib.nixosSystem {
    modules = [
      (./. + "/${mainUser}@${hostName}")
      ../modules/nixos-core.nix
      {
        nix.registry.nixpkgs.flake = nixpkgs;
      }
    ];
    specialArgs = {
      inherit
        hostInformation
        hostName
        home-manager
        nur
        agenix
        nix-index-database;
    };
  })
  (lib.attrsets.filterAttrs (_: v: v.type == "nixos") self.hosts)
