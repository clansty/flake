{ pkgs, ... }:
{
  services.karabiner-elements.enable = true;
  environment.systemPackages = with pkgs; [
    openssh
    vscode
    iterm2
    jetbrains.webstorm jetbrains.idea-ultimate
    inkscape
    postman navicat
    stats alt-tab
    tdesktop-mac
    typora-crack
    qspace-pro
    iproute2mac
    pkgs.jdk11
    balena-etcher
    yesplaymusic
  ];
}
