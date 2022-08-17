# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "nvme" "usbhid" "usb_storage" "uas" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" "wl" ];
  boot.extraModulePackages = [ config.boot.kernelPackages.broadcom_sta ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/e63aab1d-0a59-4c43-9fb6-ab92dd897378";
      fsType = "btrfs";
      options = [ "subvol=@nixos/@" "compress=zstd:3" ];
    };

  fileSystems."/home" =
    { device = "/dev/disk/by-uuid/e63aab1d-0a59-4c43-9fb6-ab92dd897378";
      fsType = "btrfs";
      options = [ "subvol=@nixos/@home" "compress=zstd:3" ];
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/67E3-17ED";
      fsType = "vfat";
    };

  swapDevices = [ 
    { 
      device = "/dev/disk/by-uuid/f3a145c4-67e3-4eef-a226-bea8e4dd168f";
    }
  ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  # networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp0s31f6.useDHCP = lib.mkDefault true;

  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  # high-resolution display
  hardware.video.hidpi.enable = lib.mkDefault true;
}
