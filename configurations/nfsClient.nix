{ baseDir, ... }:
{
#  fileSystems = {
#    "${baseDir}/shares" = {
#      device = "//11.11.1.3/shares";
#      fsType = "cifs";
#      options = [ "nofail" "credentials=${(import utils/secrets.nix).smbSecrets}" "uid=1000" "gid=100" "vers=3" ];
#    };

#    "${baseDir}/backups" = {
#      device = "//11.11.1.3/backups";
#      fsType = "cifs";
#      options = [ "nofail" "credentials=${(import utils/secrets.nix).smbSecrets}" "uid=1000" "gid=100" "vers=3" ];
#    };

#    "${baseDir}/saeziae" = {
#      device = "172.22.2.1:/srv/nfs4/shares";
#      fsType = "nfs";
#      options = [ "nfsvers=4.2" "nofail" ];
#    };
#  };
}
