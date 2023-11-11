{
  description = "haenoe's configuration files - built with nix flakes";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-utils.url = "github:numtide/flake-utils";
    deploy-rs = {
      url = "github:serokell/deploy-rs";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        utils.follows = "flake-utils";
      };
    };
    nur.url = "github:nix-community/NUR";
    agenix = {
      url = "github:ryantm/agenix";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        home-manager.follows = "home-manager";
      };
    };
  };

  outputs = { self, nixpkgs, home-manager, deploy-rs, nur, agenix, ... } @ inputs:
    {
      nixosConfigurations = (import ./hosts {
        inherit home-manager inputs nur agenix nixpkgs;
      });
      deploy = {
        user = "root";
        # remoteBuild = true;
        autoRollback = false;
        nodes = {
          mercury = {
            hostname = "192.168.122.144";
            profiles.system.path = deploy-rs.lib.x86_64-linux.activate.nixos self.nixosConfigurations.mercury;
          };
          saturn = {
            hostname = "202.61.236.225";
            profiles.system.path = deploy-rs.lib.x86_64-linux.activate.nixos self.nixosConfigurations.saturn;
          };
          # pluto = {
          #   hostname = "192.168.178.71";
          #   profiles.system.path = deploy-rs.lib.aarch64-linux.activate.nixos self.nixosConfigurations.pluto;
          # };
        };
      };
      checks = builtins.mapAttrs (system: deployLib: deployLib.deployChecks self.deploy) deploy-rs.lib;
    };
}
