{ darwinHelper, lib }:
let
  version = "2.7.39";
in
darwinHelper.packCommonMacApp {
  inherit version;
  pname = "stats";
  src = darwinHelper.fetchdmg {
    url = "https://github.com/exelban/stats/releases/download/v${version}/Stats.dmg";
    sha256 = "sha256-zKcsDd3ygGCk8WuJorNmv03FGIT2gtF5HU5FajegpFk=";
  };
  meta = with lib; {
    description = "macOS system monitor in your menu bar";
    homepage = "https://github.com/exelban/stats";
    license = licenses.mit;
    platforms = [ "x86_64-darwin" "aarch64-darwin" ];
  };
}
