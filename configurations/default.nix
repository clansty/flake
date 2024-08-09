inputs:
let
  mkLinux = { name, arch ? "x86_64", modules ? [ ] }: {
    name = "${name}";
    value = inputs.nixpkgs.lib.nixosSystem {
      system = "${arch}-linux";
      modules = [
        inputs.nur.nixosModules.nur
        inputs.home-manager.nixosModules.home-manager
        inputs.chaotic.nixosModules.default
        inputs.nix-index-database.nixosModules.nix-index
        inputs.workspace-config.nixosModules.apps
        inputs.workspace-config.nixosModules.starship
        { networking.hostName = "${name}"; }
      ] ++
      map (name: import ./defaultModules/${name}) (builtins.attrNames (builtins.readDir ./defaultModules)) ++
      modules;

      specialArgs = {
        inherit inputs arch;
        flake = inputs.self;
        isLinux = true;
        homeOnly = false;
        profileName = "nixos";
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
  nixos =
    let
      dirContents = builtins.readDir ./machines;
      mkLinuxFromName = name: mkLinux ((import ./machines/${name} inputs) // { name = name; });
      names = builtins.attrNames dirContents;
    in
    builtins.listToAttrs (map (mkLinuxFromName) names);
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
