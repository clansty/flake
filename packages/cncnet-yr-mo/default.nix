{ stdenv
, fetchzip
, fetchurl
, lib
, wine
, winetricks
, writeShellScript
, makeDesktopItem
, copyDesktopItems
, zstd
, symlinkJoin
, ...
}:

let
  moFiles = fetchzip {
    url = "https://repo.nya.fish/mental-omega.tar";
    sha256 = "cI2fFD3XU4keu6kxWPCI/4IGOOaXVIAZvKNOGttdopk=";
  };

  yrFiles = stdenv.mkDerivation rec {
    pname = "yr-files";
    version = "8.16.2-1";
    src = fetchurl {
      url = "https://mirrors.nya.fish/archlinux/x86_64/ra2yr-cncnet-8.16.2-1-x86_64.pkg.tar.zst";
      sha256 = "2ASXqJTt/JpD6/9X86WtdEratkuvwxhDHpPJPRdUNFI=";
    };
    unpackPhase = ''
      ${zstd}/bin/zstd -dc ${src} | tar -xf -
    '';
    installPhase = ''
      mkdir -p $out
      cp -r usr/share/ra2yr-cncnet.tar.gz $out
      cp usr/share/icons/hicolor/256x256/apps/ra2yr-cncnet.png $out
    '';
  };

  commonInit = writeShellScript "init" ''
    APPDIR="$HOME/.cncnet"
    export WINEPREFIX="$APPDIR/wine"

    mkdir -p $WINEPREFIX

    export WINEARCH=win32

    if [ ! -f "$APPDIR/xna_installed" ]; then
      PATH=${wine}/bin:$PATH ${winetricks}/bin/winetricks xna40
      PATH=${wine}/bin:$PATH ${winetricks}/bin/winetricks winxp
      touch "$APPDIR/xna_installed"
    fi

    export WINEDLLOVERRIDES="ddraw=n,b"
  '';

  runMo = writeShellScript "init" ''
    source ${commonInit}
    RW_DATADIR="$APPDIR/mo"
    mkdir -p $RW_DATADIR

    ln -sf "${moFiles}"/{Resources,MapsMO,Ares.dll,Ares.dll.inj,BINKW32.DLL,Blowfish.dll,clientupdt.dat,cncnet5.dll,cncnet5mo.dll,*.mix,*.exe,qres.dat,qres32.dll} "$RW_DATADIR/"
    cp -rn "${moFiles}"/{INI,"Map Editor","Map Renderer",Maps,*.ini,version} "$RW_DATADIR/"
    chmod -R +w $RW_DATADIR/*
    # nix 权限有问题

    ${wine}/bin/wine "$RW_DATADIR/Resources/clientxna.exe"
  '';

  runYr = writeShellScript "init" ''
    source ${commonInit}
    RW_DATADIR="$APPDIR/ra2yr-cncnet"
    if [ ! -f "$RW_DATADIR/CnCNetYRLauncher.exe" ]; then
      tar -xvf ${yrFiles}/ra2yr-cncnet.tar.gz -C $APPDIR
    fi

    ${wine}/bin/wine "$RW_DATADIR/Resources/clientxna.exe"
  '';

  moIcon = makeDesktopItem {
    name = "mental-omega";
    exec = runMo;
    comment = "Mental Omega is a free unofficial expansion pack for Command & Conquer Red Alert 2 Yuri's Revenge.";
    desktopName = "Mental Omega";
    categories = [ "Game" ];
    icon = ./mental-omega.png;
  };

  yrIcon = makeDesktopItem {
    name = "yuris-revenge";
    exec = runYr;
    desktopName = "Yuri's Revenge";
    categories = [ "Game" ];
    icon = "${yrFiles}/ra2yr-cncnet.png";
  };
in
symlinkJoin
{
  name = "cncnet-yr-mo";
  paths = [ moIcon yrIcon ];
}
