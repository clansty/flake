{ config, pkgs, lib, ... }:

let
  pkgsX86 = (import pkgs.path { 
    system = "i686-linux";
    config.allowUnfree = true; 
  });
  callPackageX86 = lib.callPackageWith pkgsX86;
  pkgsX64 = (import pkgs.path { 
    system = "x86_64-linux";
    config.allowUnfree = true; 
  });
  callPackageX64 = lib.callPackageWith pkgsX64;
in
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
  ]) ++ (
    [
      (callPackageX86 ../packages/cncnet-yr-mo {})
    ]
  );
}
