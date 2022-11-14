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
  };
}
