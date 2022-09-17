{ pkgs, ... }:
{
  services.karabiner-elements.enable = true;
  environment.systemPackages = with pkgs; [
    openssh
    vscode
    iterm2
    jetbrains.webstorm
    inkscape
    postman
    stats alt-tab
    tdesktop-mac
    typora-crack
    qspace-pro
    iproute2mac
    pkgs.jdk11
  ];
}
