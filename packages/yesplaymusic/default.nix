{ stdenv
, fetchurl
, electron
, lib
, makeWrapper
, makeDesktopItem
, copyDesktopItems
, ...
} @ args:

stdenv.mkDerivation rec {
  pname = "yesplaymusic";
  version = "0.4.5";
  src = fetchurl {
    url = "https://github.com/qier222/YesPlayMusic/releases/download/v${version}/YesPlayMusic-${version}.pacman";
    sha256 = "d7xHCTz1+VT48I/iLpGp0NwtjYQU+FwJISbtufvsJuU=";
  };

  # 解压 DEB 包
  unpackPhase = ''
    tar -xf ${src}
  '';

  buildInputs = [ makeWrapper ];
  nativeBuildInputs = [ copyDesktopItems ];

  installPhase = ''
    runHook preInstall
    
    mkdir -p $out/bin

    cp -r usr/share $out/share
    rm -rf "$out/share/applications"
    install -Dm644 "opt/YesPlayMusic/resources/app.asar" "$out/app.asar"

    makeWrapper ${electron}/bin/electron $out/bin/${pname} \
      --add-flags "$out/app.asar"

    runHook postInstall
  '';

  desktopItems = [ (makeDesktopItem {
    name = "yesplaymusic";
    exec = "yesplaymusic";
    comment = "A third party music application for Netease Music.";
    desktopName = "YesPlayMusic";
    categories = [ "AudioVideo" "Audio" "Music" ];
    icon = "yesplaymusic";
  }) ];
}