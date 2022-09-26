{ pkgs, ... }:
{
  services.karabiner-elements.enable = true;
  programs.nix-index.enable = true;
  programs.man.enable = true;
  environment.systemPackages = with pkgs; [
    openssh
    vscode
    iterm2
    jetbrains.webstorm
    inkscape
    postman navicat
    stats alt-tab
    tdesktop-mac
    typora-crack
    qspace-pro
    iproute2mac
    pkgs.jdk11
    balena-etcher
  ];
}
