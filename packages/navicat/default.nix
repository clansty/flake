{ appimageTools
, fetchurl
, makeDesktopItem
, stdenvNoCC
, darwinHelper
, lib
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
    src = darwinHelper.fetchdmg {
      url = "https://mac.qdrayst.com/02/Navicat%20Premium%2016.1.1_zh-CN_macwk.com.dmg";
      sha256 = "sha256-BnLlVXB6wqw+rFDech833XB4i66z8SRz3fkkTNp4dYk=";
    };
    meta = with lib; {
      platforms = [ "x86_64-darwin" "aarch64-darwin" ];
    };
  }
