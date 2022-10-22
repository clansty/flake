{ darwinHelper, lib }:
let
  version = "4.2.4";
  pname = "TDesktop";
in
  darwinHelper.packCommonMacApp {
    inherit pname version;
    src = darwinHelper.fetchdmg {
      url = "https://github.com/telegramdesktop/tdesktop/releases/download/v${version}/tsetup.${version}.dmg";
      sha256 = "sha256-awkBGghU3A/dDW2GUOSayI4hmjtux+VM76uX37c91ME=";
    };
    meta = with lib; {
      homepage = "https://desktop.telegram.org/";
      license = licenses.gpl3;
      platforms = [ "x86_64-darwin" "aarch64-darwin" ];
    };
  }
