{ stdenv
, fetchurl
, lib
, dpkg
, writeShellScript
, runCommand
, ...
}:
let
  origin = stdenv.mkDerivation rec {
    pname = "ExaGear-origin";
    version = "2.0.0.B005";
    src = fetchurl {
      url = "https://mirrors.huaweicloud.com/kunpeng/archive/ExaGear/ExaGear_2.0.0.tar.gz";
      sha256 = "pVTFP3qLb4rS65FYVxZ8SGwYadEkoIfHwbZGoCp45Ao=";
    };
    installPhase = ''
      ${dpkg}/bin/dpkg -x ExaGear_Server_for_Ubuntu20/release/exagear-core-x32a64_2493_arm64.deb 32
      ${dpkg}/bin/dpkg -x ExaGear_Server_for_Ubuntu20/release/exagear-core-x64a64_2493_arm64.deb 64
      # ${dpkg}/bin/dpkg -x ExaGear_Server_for_Ubuntu20/release/exagear-guest-for-ubuntu-2004-x86-64_2493_all.deb guest
      # ${dpkg}/bin/dpkg -x ExaGear_Server_for_Ubuntu20/release/exagear-integration_2493_all.deb inte
      # ${dpkg}/bin/dpkg -x ExaGear_Server_for_Ubuntu20/release/exagear-utils_2493_all.deb util
      install -Dm755 64/opt/exagear/bin/ubt_x64a64_al $out/bin/ubt_x64a64_al
      install -Dm755 32/opt/exagear/bin/ubt_x32a64_al $out/bin/ubt_x32a64_al
    '';
  };

  wrapper64 = writeShellScript "wrapper" ''
    exec -- ${origin}/bin/ubt_x64a64_al -- $*
  '';

  wrapper32 = writeShellScript "wrapper" ''
    exec -- ${origin}/bin/ubt_x32a64_al -- $*
  '';
in
runCommand "ExaGear" {} ''
  install -Dm755 ${wrapper64} $out/bin/64
  install -Dm755 ${wrapper32} $out/bin/32
''
