{ darwinHelper, lib }:
let
  version = "4.2.0";
  pname = "TDesktop";
in
  darwinHelper.packCommonMacApp {
    inherit pname version;
    src = darwinHelper.fetchdmg {
      url = "https://github.com/telegramdesktop/tdesktop/releases/download/v${version}/tsetup.${version}.dmg";
      sha256 = "06949gll8znnbdzp36018lvz3j5n22pfxc2a7r3zf0ib18gc1y34";
    };
    meta = with lib; {
      homepage = "https://desktop.telegram.org/";
      license = licenses.gpl3;
      platforms = [ "x86_64-darwin" "aarch64-darwin" ];
    };
  }
