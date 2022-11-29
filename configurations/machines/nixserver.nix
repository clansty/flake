{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [
      (modulesPath + "/virtualisation/proxmox-lxc.nix")
    ];

  # system.build.installBootLoader = lib.mkForce "";

  # networking = {
  #   dhcpcd.enable = false;
  #   interfaces.enp6s18.ipv4.addresses = [{
  #     address = "172.16.0.72";
  #     prefixLength = 24;
  #   }];
  #   defaultGateway = {
  #     address = "172.16.0.2";
  #     interface = "enp6s18";
  #   };
  #   nameservers = [ "172.16.0.2" ];
  # };
}
