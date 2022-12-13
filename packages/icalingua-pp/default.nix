{ fetchurl
, electron_21
, lib
, makeDesktopItem
, system
, ...
} @ args:

let
  version = "2.7.8";

  srcs = { 
    aarch64-linux = {
      url = "https://github.com/Icalingua-plus-plus/Icalingua-plus-plus/releases/download/v${version}/app-arm64.asar";
      sha256 = "1l0i3s43dvxfh7js24jycsg484nlffbynmabzwmpaj3awiw8dza7";
    };
    x86_64-linux = {
      url = "https://github.com/Icalingua-plus-plus/Icalingua-plus-plus/releases/download/v${version}/app-x86_64.asar";
      sha256 = "1wcscs94s471i7bv1ah8g74lws7qi0ldxnhnf008xha3aii402p3";
    };
    armv7l-linux = {
      url = "https://github.com/Icalingua-plus-plus/Icalingua-plus-plus/releases/download/v${version}/app-armv7l.asar";
      sha256 = "10psyglarrn2r75vlpdj8hmhv99r9nn6qnbzbxby3a786gngm05a";
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
