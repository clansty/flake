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
    # balena-etcher
    icalingua-pp
    ((tdesktop.override {
      qtwayland = null;
    }).overrideAttrs (oldAttrs: {
      pname = "t64";
      version = "1.0.44";
      src = fetchFromGitHub {
        owner = "TDesktop-x64";
        repo = "tdesktop";
        rev = "v1.0.44";
        fetchSubmodules = true;
        sha256 = "hrbdSl1ymwMzVnQri47D41ui8fPLHgD9wN9veQ2ifDM=";
      };
      cmakeFlags = oldAttrs.cmakeFlags ++ [
        "-DDESKTOP_APP_DISABLE_WAYLAND_INTEGRATION=ON"
      ];
    }))
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
