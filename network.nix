{ config, pkgs, ... }:

{
    networking = {
        hostName = "PROGYNOVA";
        useDHCP = false;
        interfaces.enp7s0.useDHCP = true;
        extraHosts = "192.168.31.154  proxy
                      192.168.31.154  lwrpi";
        proxy={
            default = "http://proxy:7890/";
            noProxy = "127.0.0.1,localhost,internal.domain";
        };
        firewall.enable = false;
    };
}