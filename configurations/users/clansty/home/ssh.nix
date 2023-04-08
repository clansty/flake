{
  programs.ssh = {
    enable = true;
    compression = true;
    # controlMaster = "auto";
    # controlPersist = "4h";
    forwardAgent = true;
    serverAliveCountMax = 10;
    serverAliveInterval = 30;
    extraConfig = ''
      TCPKeepAlive yes
      User clansty
    '';
    matchBlocks = {
      api7.hostname = "api7.lwqwq.com";
      repo.hostname = "repo.lwqwq.com";
      nas.hostname = "nas.c5y.moe";
      dev-vm.hostname = "dev-vm.c5y.moe";
      loong.hostname = "11.11.1.6";
      sv2.hostname = "11.11.1.9";
      nj-router.hostname = "172.16.2.1";
      nj-box.hostname = "172.16.2.10";
      nc-router.hostname = "172.16.1.1";
      nc-router.user = "root";
      nc-pve.hostname = "172.16.1.5";
      nc-pve.user = "root";
      pve.hostname = "pve.c5y.moe";
      pve.user = "root";
      docker-host.hostname = "docker-host.c5y.moe";
      router.hostname = "router.c5y.moe";
      gamming.hostname = "gamming-windows.c5y.moe";
      gamming.user = "clans";
      # QEMU RISC-V
      rv.hostname = "172.17.0.3";
      rv.proxyJump = "dev-vm";
      rv.user = "root";
    };
  };
}
