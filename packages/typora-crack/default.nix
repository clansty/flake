{ darwinHelper, lib, fetchzip }:
let
  version = "1.4.3";
in
darwinHelper.packCommonMacApp {
  inherit version;
  pname = "Typora";
  src = fetchzip {
    url = "https://dl.lwqwq.com/d/应用/文档/Typora.app.zip";
    sha256 = "sha256-qF4X/zSsbCgi/0PGswWAXd7qogv23UJz+sj96K6xHME=";
    stripRoot = false;
  };
  meta = with lib; {
    platforms = [ "x86_64-darwin" "aarch64-darwin" ];
  };
}
