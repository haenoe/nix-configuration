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
    nix-index-database = {
      url = "github:Mic92/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    stylix.url = "github:danth/stylix";
  };

  outputs = { self, ... } @ inputs: {
    hosts = {
      mercury = {
        mainUser = "haenoe";
        system = "x86_64-linux";
        deploy = false;
        type = "nixos";
      };
      pluto = {
        mainUser = "haenoe";
        address = "192.168.178.71";
        system = "aarch64-linux";
        deploy = true;
        type = "nixos";
      };
      saturn = {
        mainUser = "haenoe";
        address = "100.107.69.134";
        system = "x86_64-linux";
        deploy = true;
        type = "nixos";
      };
      mars = {
        mainUser = "i588211";
        system = "aarch64-darwin";
        deploy = false;
        type = "home-manager";
      };
      neptune = {
        mainUser = "haenoe";
        address = "192.168.178.97";
        system = "x86_64-linux";
        deploy = true;
        type = "nixos";
      };
    };
    nixosConfigurations = import ./hosts/nixos.nix {
      inherit
        self
        inputs
        ;
    };
    homeConfigurations = import ./hosts/home-manager.nix {
      inherit
        self
        inputs
        ;
    };
    deploy = import ./hosts/deploy.nix {
      inherit
        self
        inputs
        ;
    };
    checks = builtins.mapAttrs (system: deployLib: deployLib.deployChecks self.deploy) inputs.deploy-rs.lib;
    devShells =
      inputs.nixpkgs.lib.genAttrs [ "x86_64-linux" ]
        (system:
          let
            pkgs = inputs.nixpkgs.legacyPackages.${system};
          in
          {
            default = pkgs.mkShell {
              nativeBuildInputs = with pkgs; [
                inputs.agenix.packages.${system}.default
                nil
                deploy-rs
                nixpkgs-fmt
              ];
            };
          });
  };
}
