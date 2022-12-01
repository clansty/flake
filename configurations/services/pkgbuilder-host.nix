{
  virtualisation.docker.enable = true;
  users.users.builder = {
    home = "/nohome";
    isNormalUser = true;
    extraGroups = [ "docker" ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBG81MB+43JkHMqkjD4RsdFdvF12RVNkPlCbGz9ynaP4 clansty@clansty-m1"
    ];
  };
}
