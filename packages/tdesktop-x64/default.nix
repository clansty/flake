{ darwinHelper, lib, stdenvNoCC, tdesktop, fetchFromGitHub }:
let
  version = "1.0.57";
  pname = "TDesktop-x64";
in
if stdenvNoCC.isLinux then
  tdesktop.overrideAttrs
    (oldAttrs: {
      inherit pname version;
      src = fetchFromGitHub {
        owner = "TDesktop-x64";
        repo = "tdesktop";
        rev = "v${version}";
        fetchSubmodules = true;
        sha256 = "jU8K89Spgqnh0VFPNFX6VkbFpl/c3v8/Q2Opklu16fg=";
      };
      # cmakeFlags = oldAttrs.cmakeFlags ++ [
      #   "-DDESKTOP_APP_DISABLE_WAYLAND_INTEGRATION=ON"
      # ];
    })
else
  darwinHelper.packCommonMacApp {
    inherit pname version;
    src = darwinHelper.fetchdmg {
      url = "https://github.com/TDesktop-x64/tdesktop/releases/download/v${version}/64Gram_${version}_mac.dmg";
      sha256 = "037fpmss4cz3xjgkn1d9f99ckkmgvdz1gb6jl6066a21zjpjkfk5";
    };
    meta = with lib; {
      homepage = "https://github.com/TDesktop-x64/tdesktop";
      license = licenses.gpl3;
      platforms = [ "x86_64-darwin" "aarch64-darwin" ];
    };
  }
