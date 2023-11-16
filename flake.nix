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
      hosts = {
        mercury = {
          mainUser = "haenoe";
          system = "x86_64-linux";
          type = "nixos";
        };
        pluto = {
          mainUser = "haenoe";
          system = "aarch64-linux";
          type = "nixos";
        };
        saturn = {
          mainUser = "haenoe";
          address = "100.107.69.134";
          system = "x84_64-linux";
          type = "nixos";
        };
        mars = {
          mainUser = "i588211";
          system = "aarch64-darwin";
          type = "home-manager";
        };
      };
      nixosConfigurations = import ./hosts/nixos.nix {
        inherit self home-manager inputs nur agenix nixpkgs;
      };
      homeConfigurations = import ./hosts/home-manager.nix {
        inherit self home-manager inputs nixpkgs;
      };
      deploy = import ./hosts/deploy.nix {
        inherit deploy-rs self;
      };
      checks = builtins.mapAttrs (system: deployLib: deployLib.deployChecks self.deploy) deploy-rs.lib;
    };
}
