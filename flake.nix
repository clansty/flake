{
  description = "Clansty's Nix configurations and packages";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    sauricat.url = "github:sauricat/flakes/main";
    nur.url = github:nix-community/NUR;
    xremap-flake.url = "github:xremap/nix-flake";
    superstar-checkin.url = "github:clansty/superstar-checkin";
    q2tg.url = "github:clansty/Q2TG/f1fb1275c8e8c06867ec44b4e71dcd3e3c4234d4";
    darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs:
    let
      configurations = import ./configurations inputs;
    in
    {
      overlays.clansty = self: super:
        let
          dirContents = builtins.readDir ./packages;
          genPackage = name: {
            inherit name;
            value = self.callPackage (./packages + "/${name}") { };
          };
          names = builtins.attrNames dirContents;
        in
        builtins.listToAttrs (map genPackage names);
      nixosConfigurations = configurations.nixos;
      darwinConfigurations = configurations.darwin;
    };
}
