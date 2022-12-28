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
  systemd.targets.sync-repo = {
    wants = [ "sync-repo-archlinux.service" "sync-repo-archlinuxarm.service" "sync-repo-archriscv.service" ];
    after = [ "sync-repo-archlinux.service" "sync-repo-archlinuxarm.service" "sync-repo-archriscv.service" ];
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
  systemd.timers.sync-repo = {
    wantedBy = [ "timers.target" ];
    partOf = [ "sync-repo.target" ];
    timerConfig = {
      OnCalendar = "*-*-* 02,14:00:00";
      Unit = "sync-repo.target";
    };
  };
}
