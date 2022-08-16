{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    sauricat.url = "github:sauricat/flakes/main";
  };

  outputs = { self, nixpkgs, ... }@inputs: {
    nixosConfigurations.clansty-nixos = inputs.nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./configuration.nix
      ];
      specialArgs = { inherit inputs; };
    };
  };
}