{ darwinHelper, lib, stdenvNoCC, tdesktop, fetchFromGitHub }:
let
  version = "1.0.44";
  pname = "TDesktop-x64";
in
if stdenvNoCC.isLinux then
  (tdesktop.override {
    qtwayland = null;
  }).overrideAttrs
    (oldAttrs: {
      inherit pname version;
      src = fetchFromGitHub {
        owner = "TDesktop-x64";
        repo = "tdesktop";
        rev = "v${version}";
        fetchSubmodules = true;
        sha256 = "hrbdSl1ymwMzVnQri47D41ui8fPLHgD9wN9veQ2ifDM=";
      };
      cmakeFlags = oldAttrs.cmakeFlags ++ [
        "-DDESKTOP_APP_DISABLE_WAYLAND_INTEGRATION=ON"
      ];
    })
else
  darwinHelper.packCommonMacApp {
    inherit pname version;
    src = darwinHelper.fetchdmg {
      url = "https://github.com/TDesktop-x64/tdesktop/releases/download/v${version}/64Gram_${version}_mac.dmg";
      sha256 = "1daj8lqps25ph9j5sam0yzga1h5zir6w81g2r2c40712s44c2cg0";
    };
    meta = with lib; {
      homepage = "https://github.com/TDesktop-x64/tdesktop";
      license = licenses.gpl3;
      platforms = [ "x86_64-darwin" "aarch64-darwin" ];
    };
  }
