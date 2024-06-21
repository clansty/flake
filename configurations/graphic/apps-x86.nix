{ config, pkgs, ... }:

{
  programs.steam.enable = true;
  environment.systemPackages = (with pkgs; [
    jetbrains.webstorm
    google-chrome
#    red-alert2 cncnet-yr-mo minecraft
#    navicat
  ]) ++ (with config.nur.repos; [
  ]);
}
