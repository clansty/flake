{ config, pkgs, lib, ... }:

let
  foreignArch = import ../utils/foreignArch.nix { inherit pkgs lib; };

  nurCombined = pkgs.fetchFromGitHub {
    owner = "nix-community";
    repo = "nur-combined";
    rev = "397b2002b61ed26721a091a159aa642145471b48";
    fetchSubmodules = true;
    sha256 = "YHT6o1/cg4qemTzCoHTc2DAfMMf785/WiLFY/mctsgA=";
  };
in
{
  environment.systemPackages = (with pkgs; [
    gnome.gnome-tweaks
    vscode jupyter
    gparted
    arduino libusb1 libusb-compat-0_1
    remmina
    krita gimp inkscape gwenview libsForQt5.kolourpaint
    libreoffice-fresh
    vlc mpv yesplaymusic obs-studio
    balena-etcher
    icalingua-pp
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
  ]) ++ (with config.nur.repos; [
    rewine.landrop
    rewine.aliyunpan
  ]) ++ ([
    ((foreignArch.callPackageX86 "${nurCombined}/repos/xddxdd/pkgs/wine-wechat" {
      sha256 = "E0ZGFVp9h42G3iMzJ26P7WiASSgRdgnTHUTSRouFQYw=";
      winetricks = foreignArch.pkgsX86.winetricks.override { zenity = null; };
      wine = foreignArch.pkgsX86.wine.overrideAttrs (attrs: {
        preConfigure = (attrs.preConfigure or "") + ''
          echo qwq
          substituteInPlace ./configure \
            --replace '/bin/sh' '${foreignArch.pkgsX86.bash}/bin/sh'
        '';
      });
    }).overrideAttrs (attrs: {
      meta.platforms = [ "i686-linux" ];
    }))
  ]);
  services.udev.packages = [ 
    pkgs.micronucleus-udev-rules 
  ];
  nixpkgs.config.permittedInsecurePackages = [
    "electron-12.2.3"
    "electron-9.4.4"
  ];
}
