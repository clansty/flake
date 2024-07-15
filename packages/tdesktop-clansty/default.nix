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
      rev = "cad4bd8291169848d41488baac768119e23543cf";
      fetchSubmodules = true;
      sha256 = "sha256-OWsvlICPQ6HI/CEzDhy8kcyUGgPmSob7fQgia1A4FwE=";
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
