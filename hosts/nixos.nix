{ self, home-manager, inputs, nur, agenix, nixpkgs, nix-index-database }:
let
  lib = inputs.nixpkgs.lib;
in
lib.mapAttrs
  (hostName: { mainUser, ... } @ hostInformation: lib.nixosSystem {
    modules = [
      (./. + "/${mainUser}@${hostName}")
      ../modules/core.nix
      nur.nixosModules.nur
      agenix.nixosModules.default
      home-manager.nixosModules.home-manager
      nix-index-database.nixosModules.nix-index
      {
        programs.command-not-found.enable = false;
      }
      {
        nix.registry.nixpkgs.flake = nixpkgs;
      }
      {
        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;
          extraSpecialArgs = { };
        };
      }
    ];
    specialArgs = {
      inherit hostInformation hostName home-manager;
    };
  })
  (lib.attrsets.filterAttrs (_: v: v.type == "nixos") self.hosts)
