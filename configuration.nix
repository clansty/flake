{ config, pkgs, ... }:

{
    imports =
        [ 
            ./hardware-configuration.nix
            ./boot.nix
            ./network.nix
            ./environment.nix
            ./services.nix
            ./graphic/index.nix
            ./i18n.nix
            ./virtualisation.nix
            ./users.nix
            ./nur.nix
        ];
}

