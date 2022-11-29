{ config, pkgs, lib, ... }:

{
  virtualisation.docker.enable = true;
  environment.systemPackages = with pkgs; with config.nur.repos; [
    gnome.gnome-tweaks
    vscode jupyter kate
    firefox
    gparted
    arduino libusb1 libusb-compat-0_1
    remmina
    krita gimp inkscape gwenview libsForQt5.kolourpaint
    libreoffice-fresh
    vlc yesplaymusic obs-studio
    balena-etcher
    icalingua-pp
    tdesktop-x64
    rewine.landrop
    rewine.aliyunpan
    charles
  ];
  services.udev.packages = with pkgs; [ 
    micronucleus-udev-rules 
  ];
}
