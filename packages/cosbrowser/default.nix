{ appimageTools
, fetchzip
, makeDesktopItem
, ...
} @ args:

let app = appimageTools.wrapType2 {
  name = "cosbrowser";
  src =
    let
      folder = fetchzip {
        url = "https://cos5.cloud.tencent.com/cosbrowser/releases/cosbrowser-latest-linux.zip";
        sha256 = "RyAw9yz4h0emz1nsNMP2YFTptz5qukU6Ds7fmWHVCqc=";
      };
    in
    "${folder}/cosbrowser.AppImage";
};
in
makeDesktopItem {
  name = "cosbrowser";
  exec = "${app}/bin/cosbrowser --no-sandbox";
  comment = "COSBrowser - Tencent Cloud COS Client";
  desktopName = "COS Browser";
  categories = [ "Utility" ];
  icon = ./icon.png;
}
