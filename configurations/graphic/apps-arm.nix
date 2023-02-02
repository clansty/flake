{ config, pkgs, lib, ... }:

{
  environment.systemPackages = (with pkgs; [
    chromium
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
    (jetbrains.gateway.overrideAttrs (attrs: {
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
  ]);
}
