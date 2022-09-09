{ config, pkgs, ... }:

{
  imports =
    [
      ./boot.nix
      ./network.nix
      ./environment.nix
      ./services/openssh.nix
      ./graphic
      ./commandLine
      ./i18n.nix
      ./virtualisation.nix
      ./users.nix
      ./nfsClient.nix
    ];
}

