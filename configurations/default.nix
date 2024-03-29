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
        (import ./services/promtail.nix name)
      ] ++
      basicModules ++
      (if desktop then desktopModules ++ [
        (import ./backup.nix name)
      ] else [ ]) ++
      extraModules ++
      (if lxc then [ ./machines/lxc.nix ] else [ ./boot.nix ./machines/${name}.nix ]) ++
      (if arch == "x86_64" then [{
        # nixpkgs.localSystem = {
        #   gcc.arch = "znver3";
        #   gcc.tune = "znver3";
        #   system = "x86_64-linux";
        # };
      }] else [ ]);
      specialArgs = {
        inherit inputs arch secrets;
        flake = inputs.self;
        isLinux = true;
        homeOnly = false;
        profileName = "nixos";
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
        homeOnly = false;
        profileName = "darwin";
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
          homeOnly = true;
          profileName = name;
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
        ./services/pkgbuilder-nfs.nix
        ./services/pkgbuilder-host.nix
        # ./services/temperature2mqtt.nix
      ];
    }
    {
      name = "pgsql";
      extraModules = [
        ./services/postgres.nix
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
      name = "termux";
      system = "aarch64-linux";
      home = "/data/data/com.termux/files/home";
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
