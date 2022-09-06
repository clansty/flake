{ config, pkgs, ... }:

{
  imports =
    [
      ./boot.nix
      ./network.nix
      ./environment.nix
      ./services.nix
      ./graphic/index.nix
      ./commandLine/index.nix
      ./i18n.nix
      # ./virtualisation.nix
      ./users.nix
      ./nfsClient.nix
    ];
}

