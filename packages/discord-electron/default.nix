{ stdenv
, fetchurl
, electron_19
, lib
, makeDesktopItem
, nodePackages
, darwinHelper
, ...
} @ args:

# https://aur.archlinux.org/cgit/aur.git/tree/PKGBUILD?h=discord_arch_electron
let
  app = stdenv.mkDerivation rec {
    pname = "discord";
    version = if stdenv.isLinux then "0.0.20" else "0.0.268";
    src =
      if stdenv.isLinux then
        fetchurl
          {
            url = "https://dl.discordapp.net/apps/linux/${version}/${pname}-${version}.tar.gz";
            sha512 = "720bc8a8b61cbbe3566c34065f9831571da121d210e3f2876c34cb964d60bab33f8dc16f7ca758e918cd8f35a69699c0b9063782e6c95087c0baa41a6d0e7cf5";
          }
      else
        darwinHelper.fetchdmg {
          url = "https://dl.discordapp.net/apps/osx/0.0.268/Discord.dmg";
          sha256 = "0mcws05bgkddmz967va9nk5rd3k102vsrsnk4jn0dv8pnwaj7qfz";
        };

    installPhase = ''
      runHook preInstall

      ${if stdenv.isDarwin then "cd Discord.app/Contents" else ""}
    
      mkdir -p $out
      cp -r resources/{bootstrap,build_info.json} $out/
      cp ${if stdenv.isDarwin then "Resources/electron.icns" else "discord.png"} $out/

      ${nodePackages.asar}/bin/asar e resources/app.asar $out/app
      sed -i "s|process.resourcesPath|'$out'|" $out/app/app_bootstrap/buildInfo.js
      sed -i "s|settings.get(SKIP_HOST_UPDATE)|true|" $out/app/common/moduleUpdater.js
      sed -i "s|exeDir,|'$out',|" $out/app/app_bootstrap/autoStart/linux.js
      sed -i "s#^module\.paths.*;#module.paths = [(process.env.XDG_CONFIG_HOME || (process.env.HOME + \"${if stdenv.isDarwin then "/Library/Application Support" else "/.config"}\")) + \"/discord/${version}/modules\", (process.env.HOME + \"/Library/Application Support/discord/0.0.20/modules\")];#" $out/app/app_bootstrap/requireNative.js

      runHook postInstall
    '';
  };
  exec = "${electron_19}/bin/electron ${app}/app";
in
if stdenv.isLinux then
  makeDesktopItem
  {
    name = "discord";
    inherit exec;
    comment = "All-in-one voice and text chat for gamers that's free, secure, and works on both your desktop and phone.";
    desktopName = "Discord";
    categories = [ "Network" "InstantMessaging" ];
    icon = "${app}/discord.png";
    startupWMClass = "discord";
  }
else
  darwinHelper.wrapApplication {
    name = "Discord";
    inherit exec;
    icon = "${app}/electron.icns";
  }
