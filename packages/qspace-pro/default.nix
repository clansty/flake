{ darwinHelper, lib }:
let
  version = "2.9.20";
  pname = "QSpace-Pro";
  url = "https://cdn.awehunt.com/qs/rel/QSpace%20Pro_V${version}.dmg";
  sha256 = "sha256-3jDkGdoCqQGM6qQwz6UjP+Gzac9iB4A3esYvFK1lv/Y=";
in
darwinHelper.packCommonMacApp {
  inherit version pname;
  src = darwinHelper.fetchdmg { inherit url sha256; };
  meta = with lib; {
    platforms = [ "x86_64-darwin" "aarch64-darwin" ];
  };
}
