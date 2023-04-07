{ pkgs, ... }:
let
  usernameMap = pkgs.writeText "username map" ''
    clansty = i@gao4.pw
    clansty = clansty@qq.com
    luoling8192 = rbxin2003@outlook.com
  '';

  mkSimpleShare = path: {
    inherit path;
    # "access based share enum" = "yes";
    "read only" = "no";
    "guest ok" = "yes";
    "nfs4:chown" = true;
    "ea support" = false;
    "smbd max xattr size" = 2097152;
    "vfs objects" = "fruit streams_xattr shadow_copy2";
    "fruit:resource" = "stream";
    "strict locking" = "yes";
    "posix locking" = "yes";
    "level2 oplocks" = "no";
    "oplocks" = "no";
    "shadow: snapdir" = ".zfs/snapshot";
    "shadow: sort" = "desc";
    "shadow: format" = "-%Y-%m-%d-%H%M";
    "shadow: snapprefix" = "^zfs-auto-snap_\\(frequent\\)\\{0,1\\}\\(hourly\\)\\{0,1\\}\\(daily\\)\\{0,1\\}\\(monthly\\)\\{0,1\\}";
    "shadow: delimiter" = "-20";
  };
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
      backups = mkSimpleShare "/mnt/backups";
      shares = mkSimpleShare "/mnt/shares";
      windows-backup = mkSimpleShare "/mnt/windows-backup/%U" // {
        "guest ok" = "no";
        "valid users" = "clansty luoling8192";
      };
      clansty-home = mkSimpleShare "/mnt/clansty-home" // {
        "guest ok" = "no";
        "valid users" = "clansty";
        "access based share enum" = "yes";
      };
    };
  };
  services.samba-wsdd = {
    enable = true;
  };
}
