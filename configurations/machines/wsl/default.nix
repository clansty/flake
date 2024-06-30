inputs: {
  modules = [
    inputs.wsl.nixosModules.default
    ../../commandLine-desktop
    ./ssh-agent.nix
    ../../services/ssh.nix
    {
      wsl.enable = true;
      wsl.defaultUser = "clansty";
      users.mutableUsers = false;
      users.allowNoPasswordLogin = true;
      services.openssh.listenAddresses = [{
        addr = "0.0.0.0";
        port = 222;
      }];
    }
  ];
}
