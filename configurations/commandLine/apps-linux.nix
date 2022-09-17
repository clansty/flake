{ pkgs, ... }:
{
  programs = {
    git = {
      enable = true;
      config = {
        init.defaultBranch = "main";
        user = {
          email = "i@gao4.pw";
          name = "Clansty";
          signingkey = "DFE7C05195DA2F2BF14481CF3A6BE8BAF2EDE134";
        };
        credential.helper = "store";
        pull.rebase = false;
      };
    };
    adb.enable = true;
    java = {
      enable = true;
      package = pkgs.jdk11;
    };
    ssh = {
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
          ForwardAgent yes
      '';
    };
  };
  environment.systemPackages = with pkgs; [
    usbutils pciutils binutils
    traceroute
  ];
}
