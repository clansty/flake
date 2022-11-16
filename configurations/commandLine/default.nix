{ lib, isLinux, ... }:

{
  imports =
    [
      ./apps.nix
    ] ++ (lib.lists.optionals isLinux [
      ./apps-linux.nix
    ]);
}

