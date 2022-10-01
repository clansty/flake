{ callPackage }:
{
  packCommonMacApp = callPackage ./packCommonMacApp.nix;
  fetchdmg = callPackage ./fetchdmg.nix;
  wrapApplication = callPackage ./wrapApplication.nix;
}