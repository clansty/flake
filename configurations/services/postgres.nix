{ config, pkgs, ... }:

{
  services = {
    postgresql = {
      enable = true;
      package = pkgs.postgresql_14;
      enableTCPIP = true;
    };
    pgadmin = {
      enable = true;
      initialEmail = "i@gao4.pw";
      initialPasswordFile = pkgs.writeText "qwq" "password";
    };
  };
}
