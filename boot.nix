{ config, pkgs, ... }:

{
  boot.tmpOnTmpfs = true;
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = false;
  };
}
