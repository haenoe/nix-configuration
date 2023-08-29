{ self, home-manager, inputs }:
let
  lib = inputs.nixpkgs.lib;
in
{
  mercury = lib.nixosSystem {
    modules = [
      (./. + "/haenoe@mercury")
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
    ];
  };
}
