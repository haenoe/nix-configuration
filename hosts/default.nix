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
    ];
    specialArgs = {
      inherit home-manager userName;
    };
  };
}
