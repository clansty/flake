{ baseDir, ... }:
{
  fileSystems = {
    "${baseDir}/shares" = {
      device = "172.16.0.70:/mnt/data/shares";
      fsType = "nfs";
      options = [ "nfsvers=4.2" "nofail" ];
    };

    "${baseDir}/backups" = {
      device = "172.16.0.70:/mnt/data/backups";
      fsType = "nfs";
      options = [ "nfsvers=4.2" "nofail" ];
    };

    "${baseDir}/clansty" = {
      device = "//172.16.0.70/clansty";
      fsType = "cifs";
      options = [ "nofail" "credentials=${(import utils/secrets.nix).smbSecrets}" "uid=1000" "gid=100" "vers=3" ];
    };

    "${baseDir}/saeziae" = {
      device = "172.22.2.1:/srv/nfs4/shares";
      fsType = "nfs";
      options = [ "nfsvers=4.2" "nofail" ];
    };
  };
}
