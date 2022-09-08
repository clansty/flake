{ config, pkgs, ... }:

{
  programs.steam.enable = true;
  environment.systemPackages = (with pkgs; [
    jetbrains.webstorm
    postman
    google-chrome microsoft-edge
    cosbrowser
    red-alert2 cncnet-yr-mo minecraft
    navicat
  ]) ++ (with config.nur.repos; [
    rewine.typora-legacy
    linyinfeng.clash-for-windows
    linyinfeng.wemeet
  ]);
}
