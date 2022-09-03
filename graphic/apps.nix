{ config, pkgs, ... }:

{
  programs.steam.enable = true;
  environment.systemPackages = with pkgs; [
    gnome.gnome-tweaks
    vscode postman
    google-chrome microsoft-edge
    yesplaymusic
    jetbrains.webstorm jetbrains.idea-ultimate jupyter
    red-alert2 cncnet-yr-mo minecraft
    gparted etcher
    arduino libusb1 libusb-compat-0_1
    remmina navicat
    krita gimp inkscape gwenview libsForQt5.kolourpaint
    libreoffice-fresh
    vlc mpv
    (tdesktop.overrideAttrs (oldAttrs: {
      pname = "t64";
      version = "1.0.44";
      src = fetchFromGitHub {
        owner = "TDesktop-x64";
        repo = "tdesktop";
        rev = "v1.0.44";
        fetchSubmodules = true;
        sha256 = "hrbdSl1ymwMzVnQri47D41ui8fPLHgD9wN9veQ2ifDM=";
      };
    }))
  ];
  services.udev.packages = [ 
    pkgs.micronucleus-udev-rules 
    pkgs.xremap-udev-rules
  ];
  nixpkgs.config.permittedInsecurePackages = [
    "electron-12.2.3"
    "electron-9.4.4"
  ];
}
