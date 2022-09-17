{ lib, isLinux, ... }:
{
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  
  imports = [
    ./clansty
  ] ++
  (lib.lists.optionals isLinux ./security.nix);
}
