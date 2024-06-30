{
  programs.ssh = {
    forwardX11 = true;
    extraConfig = ''
      TCPKeepAlive yes
      User clansty
      ForwardAgent yes
      AddKeysToAgent no
      Compression yes
      ServerAliveInterval 30
      ServerAliveCountMax 10
      HashKnownHosts no
      UserKnownHostsFile ~/.ssh/known_hosts
      ControlMaster auto
      ControlPath ~/.ssh/master-%r@%n:%p
      ControlPersist 4h
    '';
  };
}
