{ config, pkgs, lib, modulesPath, inputs, flake, isLinux, ... }:

{
  nix =
    let
      substituters = [
        # "https://mirrors.bfsu.edu.cn/nix-channels/store/"
        "https://cache.nixos.org"
      ];
    in
    {
      settings.substituters = substituters;
      settings.trusted-substituters = substituters ++ [ "<local-substituter>" ];
      extraOptions = "experimental-features = nix-command flakes";
    };

  nixpkgs.config.allowUnfree = true;
  nixpkgs.overlays = [
    inputs.sauricat.overlays.sauricat
    flake.overlays.clansty
    inputs.deploy-rs.overlay
  ];
  nixpkgs.config.allowBroken = true;

  documentation.enable = false;

  security.pki.certificateFiles = [ ./dotfiles/ca.crt ];

  system.stateVersion = if isLinux then "22.11" else 4;

  nixpkgs.config.permittedInsecurePackages = [
    "electron-12.2.3"
    "electron-9.4.4"
    "electron-17.4.1"
  ];
}
