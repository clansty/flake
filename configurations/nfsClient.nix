{ config, ... }:
{
  fileSystems = {
    "/run/media/clansty/shares" = {
      device = "172.16.0.70:/mnt/data/shares";
      fsType = "nfs";
      options = [ "nfsvers=4.2" "nofail" ];
    };

    "/run/media/clansty/backups" = {
      device = "172.16.0.70:/mnt/data/backups";
      fsType = "nfs";
      options = [ "nfsvers=4.2" "nofail" ];
    };

    "/run/media/clansty/clansty" = {
      device = "//172.16.0.70/clansty";
      fsType = "cifs";
      options = [ "nofail" "credentials=${(import utils/secrets.nix).smbSecrets}" "uid=1000" "gid=100" "vers=3" ];
    };

    "/run/media/clansty/saeziae" = {
      device = "172.22.2.1:/srv/nfs4/shares";
      fsType = "nfs";
      options = [ "nfsvers=4.2" "nofail" ];
    };
  };
}
