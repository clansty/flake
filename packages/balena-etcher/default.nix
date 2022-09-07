{ lib
, stdenv
, fetchFromGitHub
, nodejs
, nodePackages
, electron_12
, makeDesktopItem
, callPackage
, runCommand
, pkgs
, gcc-unwrapped
, makeWrapper
}:

let
  # bp = callPackage
  #   (fetchFromGitHub ({
  #     owner = "serokell";
  #     repo = "nix-npm-buildpackage";
  #     rev = "ec9a825ad4a6f1fb2d6bb8371be827c9c8bf5b80";
  #     fetchSubmodules = true;
  #     sha256 = "53wPtqRsiaR8e3njRHZbO4lPX1W9hHdTarHEx6gE/s0=";
  #   }))
  #   { };

  src = fetchFromGitHub ({
    owner = "balena-io";
    repo = "etcher";
    rev = "v1.7.9";
    fetchSubmodules = true;
    sha256 = "3b11Y8/ZvZh7KdnrNjLDjYDVbuGfKp0mYZjSRSKm6Co=";
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

    # src = bp.buildNpmPackage {
    #   src = patchedSrc;
    # };

    src = "${nodeModules.development.package}/lib/node_modules/balena-etcher";

    dontConfigure = true;
    dontStrip = true;
    dontPatchELF = true;

    nativeBuildInputs = [ nodejs ];

    buildPhase = ''
      runHook preBuild
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
      runHook postInstall
    '';
  };

  wrapper = runCommand "wrapper" { } ''
    source ${makeWrapper}/nix-support/setup-hook
    makeWrapper ${electron_12}/bin/electron $out \
      --add-flags ${app} \
      --prefix LD_LIBRARY_PATH : "${lib.makeLibraryPath [ gcc-unwrapped.lib ]}"
  '';
in
makeDesktopItem {
  name = "balena-etcher";
  exec = wrapper;
  comment = "Flash OS images to SD cards and USB drives, safely and easily.";
  desktopName = "BalenaEtcher";
  categories = [ "Utility" ];
  icon = "${app}/assets/icon.png";
}
