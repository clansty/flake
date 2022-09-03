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

    ln -sf "${ra2files}"/{Rmcache,Taunts,*.dll,*.mmx,*.doc,*.tlb,*.nfo,*.mix,*.bmp,*.exe,*.txt,*.ico,*.dat,*.dsk,*.lcf,*.sys,*.pif} "$RW_DATADIR/"
    cp -rn "${ra2files}"/{*.ini,*.key,*.INI} "$RW_DATADIR/"
    chmod -R +w $RW_DATADIR/*
    export WINEDLLOVERRIDES="ddraw=n,b"
    ${wine}/bin/wine "$RW_DATADIR/Ra2.exe"
  '';
in
makeDesktopItem {
  name = "red-alert2";
  exec = startScript;
  comment = "Command & Conquer: Red Alert 2 is a real-time strategy video game.";
  desktopName = "Red Alert 2";
  categories = [ "Game" ];
  icon = "${ra2files}/red-alert2.png";
}
