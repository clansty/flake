{ config, pkgs, ... }:

{
  programs.steam.enable = true;
  environment.systemPackages = (with pkgs; [
    xivlauncher-cn
    jetbrains.webstorm
    google-chrome
  ]) ++ (with config.nur.repos; [
  ]);
}
