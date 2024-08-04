{
  description = "Clansty's Nix configurations and packages";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable-small";
    nur.url = "github:nix-community/NUR";
    xremap-flake.url = "github:xremap/nix-flake";
    darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    deploy-rs.url = "github:serokell/deploy-rs";
    hercules-ci = {
      url = "github:hercules-ci/nixflk";
      inputs.nixos.follows = "nixpkgs";
    };
    wsl.url = "github:nix-community/NixOS-WSL";
    sddm-sugar-candy-nix = {
      url = "gitlab:Zhaith-Izaliel/sddm-sugar-candy-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
    blurgyy.url = "github:blurgyy/flames";
    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = inputs:
    let
      configurations = import ./configurations inputs;
      dirContents = builtins.readDir ./packages;
      pkgNames = builtins.attrNames dirContents;
    in
    inputs.flake-utils.lib.eachSystem [ "x86_64-linux" "aarch64-linux" ]
      (system:
        let
          pkgs = import inputs.nixpkgs {
            inherit system;
            config.allowUnfree = true;
            config.allowUnsupportedSystem = true;
            config.allowBroken = true;
          };
          genPackage = name: {
            inherit name;
            value = pkgs.callPackage (./packages + "/${name}") { };
          };
        in
        {
          packages = builtins.listToAttrs (map genPackage pkgNames);
        }) //
    {
      overlays.clansty = final: prev:
        let
          genPackage = name: {
            inherit name;
            value = final.callPackage (./packages + "/${name}") { };
          };
        in
        builtins.listToAttrs (map genPackage pkgNames);
      nixosConfigurations = configurations.nixos;
      homeConfigurations = configurations.home;
      deploy = import ./configurations/servers.nix inputs;
    };
}
