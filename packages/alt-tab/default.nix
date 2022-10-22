{ fetchzip, darwinHelper, lib }:
let
  version = "6.47.0";
in
darwinHelper.packCommonMacApp {
  inherit version;
  pname = "AltTab";
  src = fetchzip {
    url = "https://github.com/lwouis/alt-tab-macos/releases/download/v${version}/AltTab-${version}.zip";
    sha256 = "sha256-CifPjT0LjbLk4LU1XHJ2Y5dRnNEzK7VFej3yy8+FU14=";
  };
  meta = with lib; {
    description = "Windows alt-tab on macOS";
    homepage = "https://alt-tab-macos.netlify.app/";
    license = licenses.gpl3;
    platforms = [ "x86_64-darwin" "aarch64-darwin" ];
  };
}
