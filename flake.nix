{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    sauricat.url = "github:sauricat/flakes/main";
    nur.url = github:nix-community/NUR;
  };

  outputs = { self, nixpkgs, nur, ... }@inputs: {
    overlays.clansty = self: super: let
        dirContents = builtins.readDir ./packages;
        genPackage = name: {
          inherit name;
          value = self.callPackage (./packages + "/${name}") { }; };
        names = builtins.attrNames dirContents;
      in builtins.listToAttrs (map genPackage names);
    nixosConfigurations.clansty-nixos = inputs.nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./configuration.nix
        ./machines/x1c6.nix
        nur.nixosModules.nur
      ];
      specialArgs = { 
        inherit inputs; 
        flake = self;
      };
    };
  };
}