{ arch, lib, ... }:

{
  imports =
    [
      ./displayManager.nix
      ./desktop.nix
      ./apps.nix
      ./fonts.nix
      ./ime.nix
      ./fingerprint.nix
    ] ++ (lib.lists.optionals (arch == "x86_64") [
      ./apps-x86.nix
    ]) ++ (lib.lists.optionals (arch == "aarch64") [
      ./apps-arm.nix
      ./google-keys.nix
    ]);
}

