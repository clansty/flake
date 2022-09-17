{ lib, isLinux, ... }:

{
  imports =
    [
      ./shell.nix
      ./apps.nix
    ] ++ (lib.lists.optionals isLinux [
      ./apps-linux.nix
    ]);
}

