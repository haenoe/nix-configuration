{ self, home-manager, inputs, userName, localSystem, pkgs }:
let
  lib = inputs.nixpkgs.lib;
in
{
  mercury = lib.nixosSystem {
    modules = [
      ./mercury
      {
        nixpkgs.pkgs = pkgs;
      }
      home-manager.nixosModules.home-manager
      {
        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;
          extraSpecialArgs = { };
        };
      }
    ];
    specialArgs = {
      inherit home-manager userName;
    };
  };
}
