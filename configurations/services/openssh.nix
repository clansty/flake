{ config, pkgs, ... }:

{
  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "no";
      passwordAuthentication = false;
      KbdInteractiveAuthentication = false;
    };
  };
}
