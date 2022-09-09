{ config, pkgs, ... }:

{
  # boot.tmpOnTmpfs = true;
  boot.kernelParams = [ "systemd.show_status=1" ];
  boot.loader = {
    systemd-boot.enable = true;
    systemd-boot.consoleMode = "max";
    systemd-boot.configurationLimit = 3;
    efi.canTouchEfiVariables = false;
  };
}
