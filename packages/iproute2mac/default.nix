{ fetchurl, python3, runCommand }:
let src = fetchurl {
  url = "https://github.com/brona/iproute2mac/raw/507c3c3b3769ea623e7d63056b40cd941c211785/src/ip.py";
  sha256 = "0qfh19278x4ls5kykjf65s4fwkdimszdz1yy6r388m2m1rdhghkp";
};
in
runCommand "ip" { } ''
  mkdir -p $out/bin
  cat ${src} > $out/bin/ip
  sed -i -e "s|#!/usr/bin/env python3|#! ${python3}/bin/python|" $out/bin/ip
  chmod +x $out/bin/ip
''
