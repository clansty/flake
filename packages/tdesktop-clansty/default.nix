{ telegram-desktop, fetchFromGitHub }:
let
  version = "1.2.6";
  pname = "0wgram";
in
telegram-desktop.overrideAttrs
  (oldAttrs: {
    inherit pname version;
    src = fetchFromGitHub {
      owner = "clansty";
      repo = "tdesktop";
      rev = "272cb35bb017529e300ddcd1eb74e52c92212822";
      fetchSubmodules = true;
      sha256 = "sha256-Z0QU/ZF9TOENpz1Drdz7EpgBdPTYjFTtLmsWM68RsPI=";
    };

    postInstall = ''
      substituteInPlace $out/share/applications/0wgram.desktop --replace 'Icon=0wgram' 'Icon=telegram'
    '';

    postFixup = oldAttrs.postFixup + ''
      mv $out/bin/telegram-desktop $out/bin/0wgram
    '';

    cmakeFlags = oldAttrs.cmakeFlags ++ [
      "-DDESKTOP_APP_DISABLE_WAYLAND_INTEGRATION=ON"
    ];
  })
