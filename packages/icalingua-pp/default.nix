{ fetchurl
, electron_21
, lib
, makeDesktopItem
, system
, ...
} @ args:

let
  version = "2.7.7";

  srcs = { 
    aarch64-linux = {
      url = "https://github.com/Icalingua-plus-plus/Icalingua-plus-plus/releases/download/v${version}/app-arm64.asar";
      sha256 = "1632prgzm75nx43cy866ji4nspyazfvkk317jlmy64lk700dz6za";
    };
    x86_64-linux = {
      url = "https://github.com/Icalingua-plus-plus/Icalingua-plus-plus/releases/download/v${version}/app-x86_64.asar";
      sha256 = "19j7izpq3khxa6qn15a0jknavzf6f7xmq7pk12jicls4y93whkf8";
    };
    i686-linux = {
      url = "https://github.com/Icalingua-plus-plus/Icalingua-plus-plus/releases/download/v${version}/app-ia32.asar";
      sha256 = "0zmlhp3i2mlpcvpbli5x0g16q93c0g6j29qm66nf4d8p4gm79pfg";
    };
    armv7l-linux = {
      url = "https://github.com/Icalingua-plus-plus/Icalingua-plus-plus/releases/download/v${version}/app-armv7l.asar";
      sha256 = "119bbndvcmyin6x34jfmavjmpvw4hv1w68zs34sz7xqfcpjkylm0";
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
  exec = "${electron_21}/bin/electron ${app}";
  comment = "A Linux client for QQ and more";
  desktopName = "Icalingua++";
  categories = [ "Network" "Chat" ];
  inherit icon;
}
