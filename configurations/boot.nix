{ config, pkgs, ... }:

{
  boot.tmp.cleanOnBoot = true;
  boot.kernelParams = [ "systemd.show_status=1" ];
  boot.loader = {
    systemd-boot.enable = true;
    systemd-boot.configurationLimit = 3;
    efi.canTouchEfiVariables = true;
  };
}
