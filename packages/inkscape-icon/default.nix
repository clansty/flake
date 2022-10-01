{ inkscape, darwinHelper }:
darwinHelper.wrapApplication {
  name = "Inkscape";
  icon = "${inkscape}/share/icons/hicolor/scalable/apps/org.inkscape.Inkscape.svg";
  exec = "${inkscape}/bin/inkscape";
}
