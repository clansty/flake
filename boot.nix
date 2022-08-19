{ config, pkgs, ... }:

{
  boot.tmpOnTmpfs = true;
  boot.loader = {
    systemd-boot.enable = true;
    systemd-boot.consoleMode = "max";
    systemd-boot.configurationLimit = 3;
    efi.canTouchEfiVariables = true;
  };
}
