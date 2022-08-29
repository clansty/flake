{ lib, stdenv, writeText }:

stdenv.mkDerivation rec {
  pname = "xremap-udev-rules";
  version = "0.7.5";
  phases = [ "installPhase" ];

  installPhase = ''
    runHook preInstall
    mkdir -p $out/lib/udev/rules.d/
    echo 'KERNEL=="uinput", GROUP="input", MODE="0660"' | tee $out/lib/udev/rules.d/99-input.rules
    runHook postInstall
  '';

  meta = with lib; {
    homepage = "https://github.com/k0kubun/xremap";
    platforms = platforms.linux;
  };
}
