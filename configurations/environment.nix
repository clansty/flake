{ config, pkgs, lib, modulesPath, inputs, flake, isLinux, ... }:

{
  nix = {
    settings.substituters = [
      "https://mirrors.bfsu.edu.cn/nix-channels/store"
      config.nur.repos.xddxdd._binaryCache.url
    ];
    settings.trusted-public-keys = [
      config.nur.repos.xddxdd._binaryCache.publicKey
    ];
    extraOptions = "experimental-features = nix-command flakes";
  };

  nixpkgs.config.allowUnfree = true;
  nixpkgs.overlays = [
    inputs.sauricat.overlays.sauricat
    flake.overlays.clansty
  ];
  nixpkgs.config.allowBroken = true;

  documentation.enable = false;

  security.pki.certificateFiles = [ ./dotfiles/ca.crt ];

  system.stateVersion = if isLinux then "22.11" else 4;

  nixpkgs.config.permittedInsecurePackages = [
    "electron-12.2.3"
    "electron-9.4.4"
  ];
}
