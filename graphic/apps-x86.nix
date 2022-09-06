{ config, pkgs, ... }:

{
  programs.steam.enable = true;
  environment.systemPackages = with pkgs; [
    postman
    google-chrome microsoft-edge
    cosbrowser
    red-alert2 cncnet-yr-mo minecraft
    navicat
    etcher
  ];
}
