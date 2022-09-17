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
    package = pkgs.nixFlakes;
    extraOptions = "experimental-features = nix-command flakes";
  };

  nixpkgs.config.allowUnfree = true;
  nixpkgs.overlays = [
    inputs.sauricat.overlays.sauricat
    flake.overlays.clansty
  ];
  nixpkgs.config.allowBroken = true;

  system.stateVersion = if isLinux then "22.11" else 4;
} // lib.attrsets.optionalAttrs isLinux {
  networking.firewall.enable = false;
}
