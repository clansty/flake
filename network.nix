{ config, pkgs, ... }:

{
    networking = {
        hostName = "clansty-nixos";
        enableIPv6 = true;
        interfaces.enp0s31f6 = {
            ipv4.addresses = [{
                address = "172.16.0.80";
                prefixLength = 24;
            }];
        };
        defaultGateway = "172.16.0.2";
        nameservers = ["172.16.0.2"];
        firewall.enable = false;
    };
}
