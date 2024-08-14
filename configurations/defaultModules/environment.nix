{ config, pkgs, lib, modulesPath, inputs, flake, isLinux, ... }:

{
  nix =
    let
      substituters = [
        "https://mirrors.bfsu.edu.cn/nix-channels/store/"
        "https://cache.nixos.org"
        "https://cosmic.cachix.org/"
      ];
    in
    {
      settings.substituters = substituters;
      settings.trusted-substituters = substituters ++ [ "<local-substituter>" ];
      settings.trusted-users = [ "clansty" ];
      settings.trusted-public-keys = [ "cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE=" ];
      extraOptions = "experimental-features = nix-command flakes";
    };

  nixpkgs.config.allowUnfree = true;
  nixpkgs.overlays = [
    flake.overlays.clansty
    inputs.sddm-sugar-candy-nix.overlays.default
    inputs.blurgyy.overlays.default
  ];
  nixpkgs.config.allowBroken = true;

  documentation.enable = false;
  documentation.man.generateCaches = false; # too slow

  security.pki.certificateFiles = [];

  system.stateVersion = "24.05";

  nixpkgs.config.permittedInsecurePackages = [
    "electron-12.2.3"
    "electron-17.4.1"
  ];
}
