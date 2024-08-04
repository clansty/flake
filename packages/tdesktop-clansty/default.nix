{ telegram-desktop, fetchFromGitHub, callPackage }:
let
  version = "1.4.0";
  pname = "0wgram";

  ada = callPackage ../ada-url { };
  tg_owt = callPackage ./tg_owt.nix { };
in
telegram-desktop.overrideAttrs
  (oldAttrs: {
    inherit pname version;
    src = fetchFromGitHub {
      owner = "clansty";
      repo = "tdesktop";
      rev = "1576cacb687060713733754e3952cbc27d42b93b";
      fetchSubmodules = true;
      sha256 = "sha256-Cc+ZaoaTLEZp3g4pPWWU7SfogczdaP5WJsPVI1nnOr8=";
    };

    # 似乎放在前面会优先
    buildInputs = [ ada tg_owt ] ++ oldAttrs.buildInputs;

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
