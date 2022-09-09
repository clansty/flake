{ lib, pkgs }:

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
  inherit pkgsX64 pkgsX86 callPackageX64 callPackageX86;
}
