{ appimageTools
, fetchurl
, ...
} @ args:

appimageTools.wrapType2 {
  name = "navicat";
  src = fetchurl {
    url = "http://download.navicat.com.cn/download/navicat16-premium-cs.AppImage";
    sha256 = "pdgZB6KdeS9mXOrD0+qFSvQA7RTmFVUHNcTR3+oFznA=";
  };
}