{ darwinHelper, lib }:
let
  version = "1.4.3";
in
darwinHelper.packCommonMacApp {
  inherit version;
  pname = "Typora";
  src = darwinHelper.fetchdmg {
    url = "https://mac.qdrayst.com/02/Typora_${version}_macwk.com.dmg";
    sha256 = "HOur7izaQ0+kXfEQKMLYEJ4zZmTsAfCWqRG1TfKyv0I=";
  };
  meta = with lib; {
    platforms = [ "x86_64-darwin" "aarch64-darwin" ];
  };
}
