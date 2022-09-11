{ stdenv
, fetchFromGitHub
, fetchurl
, lib
, cmake
, rlottie
, argparse
, callPackage
, zlib
, ...
} @ args:

stdenv.mkDerivation rec {
  pname = "tgs-to-gif";
  version = "4cd742e513ba11dfde4252b404401abb78ae6a99";
  src = fetchFromGitHub {
    owner = "Clansty";
    repo = pname;
    rev = version;
    fetchSubmodules = true;
    sha256 = "9ZoC/7LIgRgQPe7PSyff83THR2pY1EjgvhoMC7lZnQU=";
  };

  nativeBuildInputs = [
    cmake
    argparse
    zlib
    rlottie
  ];

  preConfigure = ''
    cat ${./CMakeLists.txt} > CMakeLists.txt
  '';

  installPhase = ''
    runHook preInstall
    install -Dm755 ./tgs_to_gif $out/bin/tgs-to-gif
    runHook postInstall
  '';
}
