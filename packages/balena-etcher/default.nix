{ lib
, stdenv
, fetchFromGitHub
, fetchurl
, nodejs-16_x
, nodePackages
, electron_12
, makeDesktopItem
, callPackage
, runCommand
, pkgs
, python3
, bash
, util-linux
}:

let
  src = fetchFromGitHub ({
    owner = "balena-io";
    repo = "etcher";
    rev = "v1.7.9";
    fetchSubmodules = true;
    sha256 = "3b11Y8/ZvZh7KdnrNjLDjYDVbuGfKp0mYZjSRSKm6Co=";
  });

  nodeHeaders = fetchurl ({
    url = "https://electronjs.org/headers/v12.2.3/node-v12.2.3-headers.tar.gz";
    sha256 = "CSoDnkA/dY9UKg+AGsrIYE4teptj2PPIwx33HHuoqsU=";
  });

  patchedSrc = runCommand "patchSrc" { } ''
    cp -r ${src} $out
    chmod +w $out
    rm -f $out/{package.json,package-lock.json}
    cp ${./package.json} $out/package.json
    cp ${./package-lock.json} $out/package-lock.json
    cp ${./node-env.nix} $out/node-env.nix
    cp ${./node-modules.nix} $out/node-modules.nix
    cp ${./node-packages-dev.nix} $out/node-packages-dev.nix
  '';

  nodeModules = import "${patchedSrc}/node-modules.nix" {
    pkgs = pkgs;
  };

  app = stdenv.mkDerivation rec {
    pname = "balena-etcher-app";
    version = "1.7.9";

    src = "${nodeModules.development.package}/lib/node_modules/balena-etcher";

    dontConfigure = true;
    dontStrip = true;
    dontPatchELF = true;

    nativeBuildInputs = [ nodejs-16_x python3 ];

    buildPhase = ''
      runHook preBuild
      mkdir -p /build/.node-gyp/12.2.3
      tar -xf ${nodeHeaders} -C /build/.node-gyp/12.2.3
      mv /build/.node-gyp/12.2.3/*/include /build/.node-gyp/12.2.3
      echo 9 > /build/.node-gyp/12.2.3/installVersion
      sed -i -e "s|#!/usr/bin/env node|#! ${nodejs-16_x}/bin/node|" node_modules/webpack/bin/webpack.js
      echo rebuild nya~
      export ELECTRON_SKIP_BINARY_DOWNLOAD=1
      export ELECTRON_OVERRIDE_DIST_PATH="${electron_12}/bin"
      DEBUG=electron-rebuild npm run postinstall --verbose --openssl_fips="" -- -f
      npm run webpack
      runHook postBuild
    '';

    installPhase = ''
      runHook preInstall
      mkdir $out
      install package.json "$out"
      cp -a {lib,generated} "$out"
      install -D assets/icon.png "$out/assets/icon.png"
      install -D lib/gui/app/index.html "$out/lib/gui/app/index.html"
      substituteInPlace $out/generated/gui.js \
        --replace '/usr/bin/pkexec' '/usr/bin/pkexec", "/run/wrappers/bin/pkexec' \
        --replace '/bin/bash' '${bash}/bin/bash' \
        --replace '"lsblk"' '"${util-linux}/bin/lsblk"'
      runHook postInstall
    '';
  };
in
makeDesktopItem {
  name = "balena-etcher";
  exec = "${electron_12}/bin/electron ${app}";
  comment = "Flash OS images to SD cards and USB drives, safely and easily.";
  desktopName = "BalenaEtcher";
  categories = [ "Utility" ];
  icon = "${app}/assets/icon.png";
}
