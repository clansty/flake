{ config, pkgs, lib, ... }:

{
  environment.systemPackages = (with pkgs; [
    gnome.gnome-tweaks
    vscode jupyter
    gparted
    arduino libusb1 libusb-compat-0_1
    remmina
    krita gimp inkscape gwenview libsForQt5.kolourpaint
    libreoffice-fresh
    vlc yesplaymusic obs-studio
    balena-etcher
    icalingua-pp
    tdesktop-x64
  ]) ++ (with config.nur.repos; [
    rewine.landrop
    rewine.aliyunpan
  ]);
  services.udev.packages = [ 
    pkgs.micronucleus-udev-rules 
  ];
  nixpkgs.config.permittedInsecurePackages = [
    "electron-12.2.3"
    "electron-9.4.4"
  ];
}
