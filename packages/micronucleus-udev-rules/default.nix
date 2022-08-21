{ lib, stdenv, writeText }:

let 
  rules = writeText "rules" ''
    SUBSYSTEMS=="usb", ATTRS{idVendor}=="16d0", ATTRS{idProduct}=="0753", MODE:="0666"
    KERNEL=="ttyACM*", ATTRS{idVendor}=="16d0", ATTRS{idProduct}=="0753", MODE:="0666", ENV{ID_MM_DEVICE_IGNORE}="1"
  '';
in
stdenv.mkDerivation rec {
  pname = "micronucleus-udev-rules";
  version = "20220821";
  phases = [ "installPhase" ];

  installPhase = ''
    runHook preInstall
    install -D ${rules} $out/lib/udev/rules.d/49-micronucleus.rules
    runHook postInstall
  '';

  meta = with lib; {
    homepage = "http://digistump.com/wiki/digispark/tutorials/linuxtroubleshooting";
    description = "UDEV Rules for Micronucleus boards including the Digispark.";
    platforms = platforms.linux;
    license = licenses.gpl3Plus;
  };
}