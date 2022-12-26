{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [
      (modulesPath + "/virtualisation/proxmox-lxc.nix")
    ];

  systemd.services.renew-lease = {
    serviceConfig.Type = "oneshot";
    script = ''
      ${pkgs.systemd}/bin/networkctl renew eth0
    '';
  };
  systemd.timers.renew-lease = {
    wantedBy = [ "timers.target" ];
    partOf = [ "renew-lease.service" ];
    timerConfig = {
      OnCalendar = "*-*-* *:00:00";
      Unit = "renew-lease.service";
    };
  };

}
