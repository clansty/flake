{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    sauricat.url = "github:sauricat/flakes/main";
    nur.url = github:nix-community/NUR;
    xremap-flake.url = "github:clansty/xremap-nix-flake";
    superstar-checkin.url = "github:clansty/superstar-checkin";
    q2tg.url = "path:/home/clansty/Projects/Q2TG";
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
    };
}
