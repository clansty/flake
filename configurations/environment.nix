{ config, pkgs, lib, modulesPath, inputs, flake, ... }:

{
  nix = {
    settings.substituters = [
      "https://mirrors.bfsu.edu.cn/nix-channels/store"
      config.nur.repos.xddxdd._binaryCache.url
    ];
    settings.trusted-public-keys = [
      config.nur.repos.xddxdd._binaryCache.publicKey
    ];
    package = pkgs.nixFlakes;
    extraOptions = "experimental-features = nix-command flakes";
  };

  nixpkgs.config.allowUnfree = true;
  nixpkgs.overlays = [
    inputs.sauricat.overlays.sauricat
    flake.overlays.clansty
  ];

  networking.firewall.enable = false;

  system.stateVersion = "22.11";
}