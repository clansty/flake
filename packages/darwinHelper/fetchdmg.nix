{ runCommand, fetchurl, url, sha256, undmg }:
let
  src = fetchurl { inherit url sha256; };
in
runCommand "dmg" { } ''
  mkdir -p $out
  cd $out
  ${undmg}/bin/undmg ${src}
'' 
