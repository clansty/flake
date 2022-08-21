{ config, pkgs, ... }:

{
  services = {
    openssh.enable = true;
    postgresql = {
      enable = true;
      package = pkgs.postgresql_14;
    };
  };
}
