{ inputs, ... }:
{
  imports = [ inputs.hercules-ci.nixosModules.qbittorrent ];
  services.qbittorrent = {
    enable = true;
  };

  users.users.qbittorrent.isSystemUser = true;
}
