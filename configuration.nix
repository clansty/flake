{ config, pkgs, ... }:

{
    imports =
        [ 
            ./hardware-configuration.nix
            ./boot.nix
            ./network.nix
            ./environment.nix
            ./services.nix
            ./desktop.nix
            ./i18n.nix
            ./fonts.nix
            ./virtualisation.nix
            ./users.nix
        ];
}

