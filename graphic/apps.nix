{ config, pkgs, ... }:

{
  programs.steam.enable = true;
  environment.systemPackages = with pkgs; [
    gnome.gnome-tweaks
    vscode
    google-chrome
    yesplaymusic
    jetbrains.webstorm
    red-alert2
    cncnet-yr-mo
    gparted etcher
    arduino libusb1 libusb-compat-0_1
    remmina
    krita gimp inkscape
    libreoffice-fresh
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
  services.udev.packages = [ pkgs.micronucleus-udev-rules ];
  nixpkgs.config.permittedInsecurePackages = [
    "electron-12.2.3"
    "electron-9.4.4"
  ];
}
