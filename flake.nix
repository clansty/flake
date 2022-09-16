{
  description = "Clansty's Nix configurations and packages";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    sauricat.url = "github:sauricat/flakes/main";
    nur.url = github:nix-community/NUR;
    xremap-flake.url = "github:clansty/xremap-nix-flake";
    superstar-checkin.url = "github:clansty/superstar-checkin";
    q2tg.url = "github:clansty/Q2TG";
    darwin = {
      url = "github:lnl7/nix-darwin/master";
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
