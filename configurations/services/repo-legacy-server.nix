{ pkgs, ... }:
{
  services.nginx = {
    enable = true;
    virtualHosts."repo.lwqwq.com" = {
      default = true;
      enableACME = true;
      forceSSL = true;
      kTLS = true;
      serverAliases = [ "clansty-repo.home.net.men.ci" "clansty-repo.net.men.ci" ];
      root = "/mnt/repo/repo";
      extraConfig = ''
        autoindex on;
        autoindex_exact_size off;
        autoindex_localtime on;
      '';
      locations = {
        "/mirrors/".alias = "/mnt/mirrors/";
      };
    };
  };
  security.acme = {
    acceptTerms = true;
    defaults = {
      email = "i@gao4.pw";
    };
  };
  systemd.services.sync-repo-archlinux = {
    serviceConfig.Type = "oneshot";
    script = ''
      ${pkgs.rsync}/bin/rsync -rlptHP --safe-links --delete-delay --delay-updates rsync://rsync.mirrors.ustc.edu.cn/archlinux/ /mnt/mirrors/archlinux/
    '';
  };
  systemd.services.sync-repo-archlinuxarm = {
    serviceConfig.Type = "oneshot";
    script = ''
      ${pkgs.rsync}/bin/rsync -rlptHP --safe-links --delete-delay --delay-updates rsync://mirrors.tuna.tsinghua.edu.cn/archlinuxarm/aarch64 /mnt/mirrors/archlinuxarm/
    '';
  };
  systemd.services.sync-repo-archriscv = {
    serviceConfig.Type = "oneshot";
    script = ''
      ${pkgs.rsync}/bin/rsync -rlptHP --safe-links --delete-delay --delay-updates rsync://archriscv.felixc.at/archriscv/ /mnt/mirrors/archriscv/
    '';
  };
  systemd.services.sync-repo-loongarchlinux = {
    serviceConfig.Type = "oneshot";
    script = ''
      ${pkgs.rsync}/bin/rsync -rlptHP --safe-links --delete-delay --delay-updates rsync://mirrors.wsyu.edu.cn/loongarch/archlinux /mnt/mirrors/loongarchlinux/
    '';
  };
  systemd.services.sync-repo-alhp = {
    serviceConfig.Type = "oneshot";
    script = ''
      ${pkgs.rsync}/bin/rsync -rlptHP --safe-links --delete-delay --delay-updates rsync://alhp.dev/alhp /mnt/mirrors/alhp/
    '';
  };
  systemd.timers.sync-repo-archlinux = {
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnCalendar = "*-*-* 02,14:00:00";
      Unit = "sync-repo-archlinux.service";
    };
  };
  systemd.timers.sync-repo-archlinuxarm = {
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnCalendar = "*-*-* 02,14:10:00";
      Unit = "sync-repo-archlinuxarm.service";
    };
  };
  systemd.timers.sync-repo-archriscv = {
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnCalendar = "*-*-* 02,14:20:00";
      Unit = "sync-repo-archriscv.service";
    };
  };
  systemd.timers.sync-repo-loongarchlinux = {
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnCalendar = "*-*-* 02,14:30:00";
      Unit = "sync-repo-loongarchlinux.service";
    };
  };
  systemd.timers.sync-repo-alhp = {
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnCalendar = "*-*-* 02,14:40:00";
      Unit = "sync-repo-alhp.service";
    };
  };
}
