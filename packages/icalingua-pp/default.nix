{ fetchurl
, electron_17
, lib
, makeDesktopItem
, system
, ...
} @ args:

let
  version = "2.7.2";

  srcs = { 
    aarch64-linux = {
      url = "https://github.com/Icalingua-plus-plus/Icalingua-plus-plus/releases/download/v${version}/app-arm64.asar";
      sha256 = "164falqiya10wr9hzc415s5nlzp1sy5815kcmip8qac9hxf7bgqd";
    };
    x86_64-linux = {
      url = "https://github.com/Icalingua-plus-plus/Icalingua-plus-plus/releases/download/v${version}/app-x86_64.asar";
      sha256 = "04dz01bbni4yyczsr112knmnxan5q6gw3a2bmqa1mzci4x8iqs5n";
    };
    i686-linux = {
      url = "https://github.com/Icalingua-plus-plus/Icalingua-plus-plus/releases/download/v${version}/app-ia32.asar";
      sha256 = "13aw08zsqp1zc878w6yzfm7lg6i6n3cr2abgpkj7f3rxzx3cpx09";
    };
    armv7l-linux = {
      url = "https://github.com/Icalingua-plus-plus/Icalingua-plus-plus/releases/download/v${version}/app-armv7l.asar";
      sha256 = "1bl1lbagwgp3lpzi21jwkqw5f17psl5k0qd7kz0ss3kisvyjbxvc";
    };
  };

  app = fetchurl srcs.${system};

  icon = fetchurl {
    url = "https://github.com/Icalingua-plus-plus/Icalingua-plus-plus/raw/e54a3a7a2d00a34b28bc02fcfbaba811e31aedf1/pkgres/512x512.png";
    sha256 = "0f0fgnhv80fwwfwlram5n078z7svnlqrh68d7gc4wl0qiig5ij44";
  };
in
makeDesktopItem {
  name = "icalingua++";
  exec = "${electron_17}/bin/electron ${app}";
  comment = "A Linux client for QQ and more";
  desktopName = "Icalingua++";
  categories = [ "Network" "Chat" ];
  inherit icon;
}
