{ stdenv
, fetchurl
, lib
, wine
, writeShellScript
, makeDesktopItem
, copyDesktopItems
, zstd
, ...
}:

let
  version = "1.0006";
  ra2files = stdenv.mkDerivation rec {
    pname = "red-alert2-files";
    inherit version;
    src = fetchurl {
      url = "https://repo.nya.fish/archlinux/pool/red-alert2-1.0006-2-x86_64.pkg.tar.zst";
      sha256 = "n0XfgkTnmbVgdW+W+LZJq9huh1zM8OUzj36IJ9tT8K0=";
    };
    unpackPhase = ''
        ${zstd}/bin/zstd -dc ${src} | tar -xf -
    '';
    installPhase = ''
      mkdir -p $out
      cp -r usr/lib/red-alert2/* $out
      cp usr/share/icons/hicolor/32x32/apps/red-alert2.png $out
    '';
  };

  startScript = writeShellScript "red-alert2" ''
    APPDIR="$HOME/.ra2"
    RW_DATADIR="$APPDIR/game"
    export WINEARCH=win32
    export WINEPREFIX="$APPDIR/wine"
    mkdir -p $RW_DATADIR $WINEPREFIX

    ln -s "${ra2files}"/{Rmcache,Taunts,*.dll,*.mmx,*.doc,*.tlb,*.nfo,*.mix,*.bmp,*.exe,*.txt,*.ico,*.dat,*.dsk,*.lcf,*.sys,*.pif} "$RW_DATADIR/"
    cp -a "${ra2files}"/{*.ini,*.key,*.INI} "$RW_DATADIR/"
    export WINEDLLOVERRIDES="ddraw=n,b"
    ${wine}/bin/wine "$RW_DATADIR/Ra2.exe"
  '';

  desktopIcon = makeDesktopItem {
    name = "Red Alert 2";
    exec = startScript;
    comment = "Command & Conquer: Red Alert 2 is a real-time strategy video game.";
    desktopName = "red-alert2";
    categories = [ "Game" ];
    icon = "${ra2files}/red-alert2.png";
  };
in
stdenv.mkDerivation {
  pname = "red-alert2";
  inherit version;
  nativeBuildInputs = [ copyDesktopItems ];
  desktopItems = [ desktopIcon ];
  phases = [ "installPhase" ];
  installPhase = ''
    runHook preInstall
    runHook postInstall
  '';

  meta = with lib; {
    description = "Command & Conquer: Red Alert 2 is a real-time strategy video game.";
    platforms = [ "x86_64-linux" ];
    license = licenses.unfreeRedistributable;
  };
}