{ config, pkgs, lib, ... }:

{
  environment.systemPackages = with pkgs; with config.nur.repos; [
    gnome-tweaks
    (vscode.override { commandLineArgs = "--disable-features=WaylandFractionalScaleV1 --enable-wayland-ime --"; })
    gparted
    arduino libusb1 libusb-compat-0_1
    remmina
    krita gimp inkscape gwenview libsForQt5.kolourpaint
    vlc yesplaymusic obs-studio
    tdesktop-clansty
  ];
  services.udev.packages = with pkgs; [ 
    micronucleus-udev-rules 
  ];
}
