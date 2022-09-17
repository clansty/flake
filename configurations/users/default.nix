{ lib, isLinux, ... }:
{
  imports = [
    ./clansty
  ] ++
  (lib.lists.optionals isLinux ./security.nix);
}
