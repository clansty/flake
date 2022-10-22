{ appimageTools
, fetchurl
, makeDesktopItem
, stdenvNoCC
, darwinHelper
, lib
, fetchzip
, ...
} @ args:

let app = appimageTools.wrapType2 {
  name = "navicat";
  src = fetchurl {
    url = "http://download.navicat.com.cn/download/navicat16-premium-cs.AppImage";
    sha256 = "pdgZB6KdeS9mXOrD0+qFSvQA7RTmFVUHNcTR3+oFznA=";
  };
};
in
if stdenvNoCC.isLinux then
  makeDesktopItem
  {
    name = "navicat";
    exec = "${app}/bin/navicat";
    comment = "Database Development Tool";
    desktopName = "Navicat Premium 16";
    categories = [ "Development" ];
    icon = ./icon.png;
  }
else
  darwinHelper.packCommonMacApp {
    pname = "navicat";
    version = "16.1.1";
    src = fetchzip {
      url = "https://dl.lwqwq.com/d/应用/服务器/Navicat%20Premium.app.zip";
      sha256 = "sha256-Xv3V4X9m8D1/1WR7WgXSAPsYgKQXLJos7RrN9wOzGDg";
      stripRoot = false;
    };
    meta = with lib; {
      platforms = [ "x86_64-darwin" "aarch64-darwin" ];
    };
  }
