{ config, pkgs, ... }:

{
    networking = {
        hostName = "clansty-nixos";
        firewall.enable = false;
    };
}
