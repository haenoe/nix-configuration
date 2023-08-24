{
  description = "haenoe's configuration files - built with nix flakes";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-utils.url = "github:numtide/flake-utils";
    deploy-rs.url = "github:serokell/deploy-rs";
  };

  outputs = { self, nixpkgs, home-manager, deploy-rs, ... } @ inputs:
    let
      userName = "haenoe";
      localSystem = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit localSystem;
        config.allowUnfree = true;
      };
    in
    {
      nixosConfigurations = (import ./hosts {
        inherit self home-manager inputs userName localSystem pkgs;
      });
      deploy = {
        user = "root";
        # remoteBuild = true;
        autoRollback = false;
        nodes = {
          "haenoe@mercury" = {
            hostname = "192.168.122.144";
            profiles.system.path = deploy-rs.lib.x86_64-linux.activate.nixos self.nixosConfigurations.mercury;
          };
          # "haenoe@pluto" = {
          #   hostname = "192.168.178.71";
          #   profiles.system.path = deploy-rs.lib.aarch64-linux.activate.nixos self.nixosConfigurations.pluto;
          # };
        };
      };
      checks = builtins.mapAttrs (system: deployLib: deployLib.deployChecks self.deploy) deploy-rs.lib;
    };
}
