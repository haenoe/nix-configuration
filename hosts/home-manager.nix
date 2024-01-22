{ self, home-manager, inputs, nixpkgs }:
let
  lib = inputs.nixpkgs.lib;
in
lib.mapAttrs
  (hostName: { mainUser, system, ... } @ hostInformation: home-manager.lib.homeManagerConfiguration {
    pkgs = nixpkgs.legacyPackages.${system};
    modules = [
      (./. + "/${mainUser}@${hostName}")
      {
        nix.registry.nixpkgs.flake = nixpkgs;
        nixpkgs.overlays = [ inputs.neovim-nightly-overlay.overlay ];
      }
    ];
    extraSpecialArgs = {
      inherit mainUser hostInformation hostName home-manager;
    };
  })
  (lib.attrsets.filterAttrs (_: v: v.type == "home-manager") self.hosts)
