{ lib, stdenv, fetchurl, makeWrapper }:

stdenv.mkDerivation rec {
  pname = "geekbench";
  version = "5.4.4";

  src = fetchurl {
    url = "https://cdn.geekbench.com/Geekbench-${version}-LinuxARMPreview.tar.gz";
    sha256 = "AGR+pEehSvCcO2Rdu0CCBD5zNGoIo+XCUoXB7EG+LRo=";
  };

  dontConfigure = true;
  dontBuild = true;

  nativeBuildInputs = [ makeWrapper ];

  installPhase = ''
    mkdir -p $out/bin
    cp -r geekbench.plar geekbench5 geekbench_aarch64 $out/bin

    for f in geekbench5 geekbench_aarch64 ; do
      patchelf --set-interpreter $(cat ${stdenv.cc}/nix-support/dynamic-linker) $out/bin/$f
      wrapProgram $out/bin/$f --prefix LD_LIBRARY_PATH : "${lib.makeLibraryPath [ stdenv.cc.cc.lib ]}:$out/lib/"
    done
  '';

  meta = with lib; {
    description = "Cross-platform benchmark";
    homepage = "https://geekbench.com/";
    sourceProvenance = with sourceTypes; [ binaryNativeCode ];
    license = licenses.unfree;
    maintainers = [ maintainers.michalrus ];
    platforms = [ "aarch64-linux" ];
  };
}