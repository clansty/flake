{ config, pkgs, lib, modulesPath, inputs, flake, isLinux, ... }:

{
  nix =
    let
      substituters = [
        "https://mirrors.bfsu.edu.cn/nix-channels/store/"
        "https://cache.nixos.org"
      ];
    in
    {
      settings.substituters = substituters;
      settings.trusted-substituters = substituters ++ [ "<local-substituter>" ];
      settings.trusted-users = [ "clansty" ];
      extraOptions = "experimental-features = nix-command flakes";
    };

  nixpkgs.config.allowUnfree = true;
  nixpkgs.overlays = [
    flake.overlays.clansty
    inputs.sddm-sugar-candy-nix.overlays.default
  ];
  nixpkgs.config.allowBroken = true;

  documentation.enable = false;

  security.pki.certificateFiles = [];

  system.stateVersion = "24.05";

  nixpkgs.config.permittedInsecurePackages = [
    "electron-12.2.3"
    "electron-17.4.1"
  ];
}
