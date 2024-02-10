{
  self,
  inputs,
}: let
  lib = inputs.nixpkgs.lib;
in
  lib.mapAttrs
  (hostName: {
      mainUser,
      system,
      ...
    } @ hostInformation:
      inputs.home-manager.lib.homeManagerConfiguration {
        pkgs = inputs.nixpkgs.legacyPackages.${system};
        modules = [
          (./. + "/${mainUser}@${hostName}")
          {
            nix.registry.nixpkgs.flake = inputs.nixpkgs;
            nixpkgs.overlays = [inputs.neovim-nightly-overlay.overlay];
          }
        ];
        extraSpecialArgs = {
          inherit (inputs) home-manager;
          inherit mainUser hostInformation hostName;
        };
      })
  (lib.attrsets.filterAttrs (_: v: v.type == "home-manager") self.hosts)
