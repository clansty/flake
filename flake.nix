{
  description = "Clansty's Nix configurations and packages";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    sauricat.url = "github:sauricat/flakes/main";
    nur.url = github:nix-community/NUR;
    xremap-flake.url = "github:xremap/nix-flake/aarch64";
    superstar-checkin.url = "github:clansty/superstar-checkin";
    q2tg.url = "github:clansty/Q2TG/b15ffc0d732ea5a116c4650e7233ed1c2f7e2fa5";
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
