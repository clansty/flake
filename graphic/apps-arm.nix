{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    chromium
    geekbench-aarch64
    (jetbrains.webstorm.overrideAttrs (attrs: {
      prePatch = ''
        echo hack fsnotifier nya~
        cp -f ${coreutils}/bin/echo bin/fsnotifier
        cp -f ${coreutils}/bin/echo bin/fsnotifier64
      '' + (attrs.prePatch or "");
      postInstall = (attrs.postInstall or "") + ''
        echo remove fsnotifier nya~
        rm $out/libexec/**/fsnotifier*
      '';
    }))
  ];
}
