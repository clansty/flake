{ darwinHelper, lib }:
let
  version = "4.2.0";
in
darwinHelper.packCommonMacApp {
  inherit version;
  pname = "Bartender";
  src = darwinHelper.fetchdmg {
    url = "https://mac.qdrayst.com/02/Bartender%20${version}_zh-CN_macwk.com.dmg";
    sha256 = "xVnMmmJowp44uPOLRwth6DTWJ58/cwEnvUrXWlXXaKU=";
  };
  meta = with lib; {
    homepage = "https://macwk.com/soft/bartender-4";
    platforms = [ "x86_64-darwin" "aarch64-darwin" ];
  };
}
