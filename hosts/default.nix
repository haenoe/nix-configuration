{ self, home-manager, inputs, nur }:
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
      address = "";
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
