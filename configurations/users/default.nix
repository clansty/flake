{ lib, isLinux, ... }:
{
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  
  imports = [
    ./clansty
    ./luoling8192
  ] ++
  (lib.lists.optional isLinux ./security.nix);
}
