inputs:
let
  basicModules = [
    ./boot.nix
    ./environment.nix
    ./services/openssh.nix
    ./commandLine
    ./i18n.nix
    ./virtualisation.nix
    ./users.nix
    ./nfsClient.nix
  ];

  desktopModules = [
    ./graphic
  ];

  mkLinux = { name, desktop ? false, arch ? "x86_64", extraModules ? [ ] }: {
    name = "clansty-${name}";
    value = inputs.nixpkgs.lib.nixosSystem {
      system = "${arch}-linux";
      modules = [
        ./machines/${name}.nix
        inputs.nur.nixosModules.nur
        { networking.hostName = "clansty-${name}"; }
      ] ++ basicModules ++ (if desktop then desktopModules else [ ]) ++ extraModules;
      specialArgs = {
        inherit inputs arch;
        flake = inputs.self;
      };
    };
  };
in
{
  nixos = builtins.listToAttrs (map mkLinux [
    {
      name = "w510";
      desktop = true;
      arch = "aarch64";
      extraModules = [
        ./graphic/xremap.nix
        ./services/code-server.nix
      ];
    }
    {
      name = "x1c";
      desktop = true;
    }
  ]);
  darwin = { };
}
