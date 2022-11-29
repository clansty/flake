inputs:
let
  basicModules = [
    ./environment.nix
    ./services/openssh.nix
    ./commandLine
    ./i18n.nix
    ./users
    ./networking.nix
  ];

  darwinModules = [
    ./environment.nix
    ./commandLine
    ./darwin
    ./users
    ./graphic/fonts.nix
  ];

  desktopModules = [
    ./graphic
    (import ./nfsClient.nix { baseDir = "/run/media/clansty"; })
    ./commandLine-desktop
  ];

  secrets = import ./utils/secrets.nix;

  mkLinux = { name, desktop ? false, arch ? "x86_64", extraModules ? [ ], lxc ? false }: {
    name = "clansty-${name}";
    value = inputs.nixpkgs.lib.nixosSystem {
      system = "${arch}-linux";
      modules = [
        inputs.nur.nixosModules.nur
        inputs.home-manager.nixosModules.home-manager
        { networking.hostName = "clansty-${name}"; }
      ] ++
      basicModules ++
      (if desktop then desktopModules else [ ]) ++
      extraModules ++
      (if lxc then [ ./machines/lxc.nix ] else [ ./boot.nix ./machines/${name}.nix ]);
      specialArgs = {
        inherit inputs arch secrets;
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
        inputs.home-manager.darwinModules.home-manager
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

  mkHome = { system, name, extraModules ? [ ], home }: {
    inherit name;
    value = inputs.home-manager.lib.homeManagerConfiguration
      {
        modules = [
          ./users/clansty/home
          { home.homeDirectory = home; }
        ];
        pkgs = inputs.nixpkgs.legacyPackages.${system};
        extraSpecialArgs = {
          inherit inputs;
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
        ./services/code-server.nix
        ./services/nginx-pc.nix
        ./emulation/riscv.nix
        ./services/samba-home.nix
        ./services/pkgbuilder-host.nix
      ];
    }
    {
      name = "nixserver";
      extraModules = [
        ./services/postgres.nix
        ./services/superstar-checkin.nix
        ./services/q2tg.nix
        ./services/ctm-record.nix
      ];
      lxc = true;
    }
    {
      name = "nextcloud";
      extraModules = [
        ./services/nextcloud.nix
      ];
      lxc = true;
    }
  ]);
  darwin = builtins.listToAttrs (map mkDarwin [
    {
      name = "m1";
      extraModules = [ ];
    }
  ]);
  home = builtins.listToAttrs (map mkHome [
    {
      name = "aarch64-darwin";
      system = "aarch64-darwin";
      home = "/Users/clansty";
    }
    {
      name = "aarch64-lima";
      system = "aarch64-linux";
      home = "/home/clansty.linux";
    }
    {
      name = "aarch64-linux";
      system = "aarch64-linux";
      home = "/home/clansty";
    }
    {
      name = "x86_64-linux";
      system = "x86_64-linux";
      home = "/home/clansty";
    }
  ]);
}
