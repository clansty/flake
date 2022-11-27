{ ... }:
{
  programs.ssh = {
    enable = true;
    compression = true;
    controlMaster = "auto";
    controlPersist = "4h";
    forwardAgent = true;
    serverAliveCountMax = 10;
    serverAliveInterval = 30;
    extraConfig = ''
      TCPKeepAlive yes
    '';
    matchBlocks = {
      api7.hostname = "api7.lwqwq.com";
      api10.hostname = "api10.lwqwq.com";
      api13.hostname = "api13.lwqwq.com";
      api16.hostname = "api16.lwqwq.com";
      repo.hostname = "repo.lwqwq.com";
      nas.hostname = "172.16.0.70";
      nasc.hostname = "172.16.0.75";
      w510.hostname = "172.16.0.81";
      loong.hostname = "172.16.0.73";
      nixsrv.hostname = "172.16.0.72";
      nj-router.hostname = "172.16.2.1";
      nj-box.hostname = "172.16.2.10";
      nc-router.hostname = "172.16.1.1";
      nc-router.user = "root";
      nc-pve.hostname = "172.16.1.5";
      nc-pve.user = "root";
    };
  };
}
