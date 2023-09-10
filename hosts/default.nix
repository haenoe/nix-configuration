{ self, home-manager, inputs, nur }:
let
  lib = inputs.nixpkgs.lib;
in
{
  mercury = lib.nixosSystem {
    modules = [
      (./. + "/haenoe@mercury")
      ../modules/core.nix
      nur.nixosModules.nur
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
      inherit home-manager;
    };
  };
  pluto = lib.nixosSystem {
    modules = [
      (./. + "/haenoe@pluto")
      ../modules/core.nix
    ];
  };
}
