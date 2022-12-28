{ pkgs, ... }:
let
  usernameMap = pkgs.writeText "username map" ''
    clansty = i@gao4.pw
    clansty = clansty@qq.com
    luoling8192 = rbxin2003@outlook.com
  '';
in
{
  services.samba = {
    enable = true;
    extraConfig = ''
      guest account = nobody
      map to guest = bad user
      vfs objects = catia
      allow insecure wide links = yes
      username map = ${usernameMap}
      unix charset = UTF-8
      fruit:aapl = yes
      fruit:encoding = native
      fruit:locking = none
      fruit:metadata = netatalk
      fruit:resource = stream
      fruit:model = MacSamba
    '';
    shares = {
      timemachine = {
        "path" = "/mnt/timemachine/%U";
        "access based share enum" = "yes";
        "read only" = "no";
        "guest ok" = "no";
        "kernel oplocks" = "no";
        "kernel share modes" = "no";
        "posix locking" = "no";
        "nfs4:chown" = true;
        "ea support" = false;
        "smbd max xattr size" = 2097152;
        "vfs objects" = "catia fruit streams_xattr";
        "fruit:metadata" = "stream";
        "fruit:resource" = "stream";
        "fruit:time machine" = "yes";
        "fruit:locking" = "none";
        "valid users" = "clansty luoling8192";
      };
      backups = {
        "path" = "/mnt/backups";
        "read only" = "no";
        "guest ok" = "yes";
        "nfs4:chown" = true;
        "ea support" = false;
        "smbd max xattr size" = 2097152;
        "vfs objects" = "fruit streams_xattr";
        "fruit:resource" = "stream";
        "strict locking" = "yes";
        "posix locking" = "yes";
        "level2 oplocks" = "no";
        "oplocks" = "no";
      };
      shares = {
        "path" = "/mnt/shares";
        "read only" = "no";
        "guest ok" = "yes";
        "nfs4:chown" = true;
        "ea support" = false;
        "smbd max xattr size" = 2097152;
        "vfs objects" = "fruit streams_xattr";
        "fruit:resource" = "stream";
        "strict locking" = "yes";
        "posix locking" = "yes";
        "level2 oplocks" = "no";
        "oplocks" = "no";
      };
    };
  };
  services.samba-wsdd = {
    enable = true;
  };
}
