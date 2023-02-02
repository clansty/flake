name:
{ pkgs, secrets, ... }:
let
  host = "pbs.c5y.moe";
  datastore = "data";
  namespace = "Hosts";

  passwdFile = pkgs.writeText "passwd" secrets.pbsPasswd.${name};
in
{
  systemd.services.pbs-backup = {
    serviceConfig.Type = "oneshot";
    script = ''
      ${pkgs.btrfs-progs}/bin/btrfs subvol delete /.snap-backup || true
      ${pkgs.btrfs-progs}/bin/btrfs subvol delete /home/.snap-backup || true
      ${pkgs.btrfs-progs}/bin/btrfs subvol delete /nix/.snap-backup || true

      ${pkgs.btrfs-progs}/bin/btrfs subvol snap -r / /.snap-backup
      ${pkgs.btrfs-progs}/bin/btrfs subvol snap -r /home /home/.snap-backup
      ${pkgs.btrfs-progs}/bin/btrfs subvol snap -r /nix /nix/.snap-backup

      export PBS_PASSWORD_FILE=${passwdFile}
      ${pkgs.proxmox-backup-client}/bin/proxmox-backup-client backup root.pxar:/.snap-backup home.pxar:/home/.snap-backup nix.pxar:/nix/.snap-backup --backup-type host --repository ${name}@pbs@${host}:${datastore} --ns ${namespace}
      
      ${pkgs.btrfs-progs}/bin/btrfs subvol delete /.snap-backup || true
      ${pkgs.btrfs-progs}/bin/btrfs subvol delete /home/.snap-backup || true
      ${pkgs.btrfs-progs}/bin/btrfs subvol delete /nix/.snap-backup || true
    '';
  };

  systemd.timers.pbs-backup = {
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnCalendar = "*-*-* *:25:00";
      Unit = "pbs-backup.service";
    };
  };
}
