{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [
      (modulesPath + "/profiles/qemu-guest.nix")
    ];

  boot.initrd.availableKernelModules = [ "uhci_hcd" "ehci_pci" "ahci" "virtio_pci" "sr_mod" "virtio_blk" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    {
      device = "/dev/disk/by-uuid/949e4750-ed9b-4304-96c7-2762fcef5d2a";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    {
      device = "/dev/disk/by-uuid/DF8D-FE13";
      fsType = "vfat";
    };

  swapDevices =
    [{ device = "/dev/disk/by-uuid/4c416bc0-624f-48f6-919e-9982d431011b"; }];

  networking = {
    dhcpcd.enable = fales;
    interfaces.enp6s18.ipv4.addresses = [{
      address = "172.16.0.72";
      prefixLength = 24;
    }];
    defaultGateway = {
      address = "172.16.0.2";
      interface = "enp6s18";
    };
    nameservers = [ "172.16.0.2" ];
  };

  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
