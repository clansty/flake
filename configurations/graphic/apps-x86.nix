{ config, pkgs, ... }:

{
  programs.steam.enable = true;
  environment.systemPackages = (with pkgs; [
    xivlauncher-cn
    jetbrains.webstorm
    microsoft-edge
  ]) ++ (with config.nur.repos; [
  ]);
}
