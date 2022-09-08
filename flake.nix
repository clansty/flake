{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    sauricat.url = "github:sauricat/flakes/main";
    nur.url = github:nix-community/NUR;
    xremap-flake.url = "github:clansty/xremap-nix-flake";
  };

  outputs = { self, nixpkgs, xremap-flake, ... }@inputs: {
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
    nixosConfigurations.clansty-w510 = inputs.nixpkgs.lib.nixosSystem {
      system = "aarch64-linux";
      modules = [
        ./configuration.nix
        ./machines/w510.nix
        inputs.nur.nixosModules.nur
        xremap-flake.nixosModules.default
        ./graphic/xremap.nix
        ./services/code-server.nix
        { networking.hostName = "clansty-w510"; }
      ];
      specialArgs = {
        inherit inputs;
        flake = self;
        arch = "aarch64";
      };
    };
    nixosConfigurations.clansty-x1c = inputs.nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./configuration.nix
        ./machines/x1c6.nix
        inputs.nur.nixosModules.nur
        { networking.hostName = "clansty-x1c"; }
      ];
      specialArgs = {
        inherit inputs;
        flake = self;
        arch = "x86_64";
      };
    };
  };
}
