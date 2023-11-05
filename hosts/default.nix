{ home-manager, inputs, nur, agenix }:
let
  lib = inputs.nixpkgs.lib;
  hosts = {
    mercury = {
      mainUser = "haenoe";
      address = "";
      system = "x86_64-linux";
    };
    pluto = {
      mainUser = "haenoe";
      address = "";
      system = "aarch64-linux";
    };
    saturn = {
      mainUser = "haenoe";
      address = "100.107.69.134";
      system = "x84_64-linux";
    };
  };
in
lib.mapAttrs
  (hostName: { mainUser, ... } @ hostInformation: lib.nixosSystem {
    modules = [
      (./. + "/${mainUser}@${hostName}")
      ../modules/core.nix
      nur.nixosModules.nur
      agenix.nixosModules.default
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
      inherit hostInformation hostName home-manager;
    };
  })
  hosts
