{
  virtualisation.docker.enable = true;
  users.users.builder = {
    home = "/nohome";
    isNormalUser = true;
    extraGroups = [ "docker" ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBG81MB+43JkHMqkjD4RsdFdvF12RVNkPlCbGz9ynaP4 clansty@clansty-m1"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAAvouMGodAlOeYKqoMNoJ3S9z3BZd52/CMYliR5JuRV dispatcher@repo-dispatcher"
    ];
  };
}
