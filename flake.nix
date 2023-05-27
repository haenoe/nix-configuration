{
  description = "A configuration all things nix.";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, home-manager, ... } @ inputs:
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
    };
}
