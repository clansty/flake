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

  darwinModules = [
    ./environment.nix
    ./commandLine
    ./users.nix
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
        isLinux = true;
      };
    };
  };

  mkDarwin = { name, arch ? "aarch64", extraModules ? [ ] }: {
    name = "clansty-${name}";
    value = inputs.darwin.lib.darwinSystem {
      system = "${arch}-darwin";
      modules = [
        inputs.nur.nixosModules.nur
        {
          networking.hostName = "clansty-${name}";
          networking.localHostName = "clansty-${name}";
          services.nix-daemon.enable = true;
        }
      ] ++ darwinModules ++ extraModules;
      specialArgs = {
        inherit inputs arch;
        flake = inputs.self;
        isLinux = false;
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
        ./services/nginx-pc.nix
        ./emulation/riscv.nix
      ];
    }
    {
      name = "x1c";
      desktop = true;
    }
    {
      name = "nixserver";
      extraModules = [
        ./services/postgres.nix
        ./services/superstar-checkin.nix
        ./services/q2tg.nix
      ];
    }
  ]);
  darwin = builtins.listToAttrs (map mkDarwin [
    {
      name = "m1";
      extraModules = [ ];
    }
  ]);
}
