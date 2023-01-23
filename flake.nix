{
  description = "Clansty's Nix configurations and packages";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    sauricat.url = "github:sauricat/flakes/main";
    nur.url = github:nix-community/NUR;
    xremap-flake.url = "github:xremap/nix-flake/5f3c5668c11d004b2b0d5f6bafdbd70da431b9a0";
    superstar-checkin.url = "github:clansty/superstar-checkin";
    q2tg.url = "github:clansty/Q2TG/8f65eeb";
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
    netease-music-sync.url = "github:clansty/netease-music-sync";
    microsoft-store-sync.url = "github:clansty/microsoft-store-sync";
  };

  outputs = inputs:
    let
      configurations = import ./configurations inputs;
    in
    {
      overlays.clansty = final: prev:
        let
          dirContents = builtins.readDir ./packages;
          genPackage = name: {
            inherit name;
            value = final.callPackage (./packages + "/${name}") { };
          };
          names = builtins.attrNames dirContents;
        in
        builtins.listToAttrs (map genPackage names);
      nixosConfigurations = configurations.nixos;
      darwinConfigurations = configurations.darwin;
      homeConfigurations = configurations.home;
      deploy = import ./configurations/servers.nix inputs;
    };
}
