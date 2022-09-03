{ pkgs, ... }:
{
  programs.ssh = {
    startAgent = true;
    extraConfig = ''
      Host *
        ServerAliveInterval 30
        ServerAliveCountMax 10
        ControlMaster auto
        ControlPath ~/.ssh/connection-%r@%h:%p
        TCPKeepAlive yes
        ControlPersist 4h
        Compression yes
    '';
  };
}
