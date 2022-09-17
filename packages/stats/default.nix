{ darwinHelper, lib }:
let
  version = "2.7.34";
in
darwinHelper.packCommonMacApp {
  inherit version;
  pname = "stats";
  src = darwinHelper.fetchdmg {
    url = "https://github.com/exelban/stats/releases/download/v${version}/Stats.dmg";
    sha256 = "0hhngd27b30i2vg3cvc7qmxgkrq0g7mmgmvc1c5nz4yvnp5s7ax3";
  };
  meta = with lib; {
    description = "macOS system monitor in your menu bar";
    homepage = "https://github.com/exelban/stats";
    license = licenses.mit;
    platforms = [ "x86_64-darwin" "aarch64-darwin" ];
  };
}
