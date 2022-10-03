{ stdenv
, fetchurl
, electron
, lib
, makeDesktopItem
, darwinHelper
, nodePackages
, ...
} @ args:

let
  app = stdenv.mkDerivation rec {
    pname = "yesplaymusic";
    version = "0.4.5";
    src =
      if stdenv.isLinux then
        fetchurl
          {
            url = "https://github.com/qier222/YesPlayMusic/releases/download/v${version}/YesPlayMusic-${version}.pacman";
            sha256 = "d7xHCTz1+VT48I/iLpGp0NwtjYQU+FwJISbtufvsJuU=";
          }
      else
        darwinHelper.fetchdmg {
          url = "https://github.com/qier222/YesPlayMusic/releases/download/v${version}/YesPlayMusic-mac-${version}-universal.dmg";
          sha256 = "1fjx0vmlvyi0i44p0vv0328rzpbsarfzsfyg3lag4vf3s9krr8a6";
        };

    # 解压 DEB 包
    unpackPhase =
      if stdenv.isLinux then ''
        tar -xf ${src}
      '' else "";

    installPhase = ''
      runHook preInstall
    
      ${nodePackages.asar}/bin/asar e "${if stdenv.isDarwin then "YesPlayMusic.app/Contents" else "opt/YesPlayMusic"}/resources/app.asar" "$out"

      runHook postInstall
    '';
  };
  icon = ./yesplaymusic.png;
  exec = "${electron}/bin/electron ${app}";
in
if stdenv.isLinux then
  makeDesktopItem
  {
    inherit icon exec;
    name = "yesplaymusic";
    comment = "A third party music application for Netease Music.";
    desktopName = "YesPlayMusic";
    categories = [ "AudioVideo" "Audio" "Music" ];
  }
else
  darwinHelper.wrapApplication {
    name = "YesPlayMusic";
    inherit icon exec;
  }
