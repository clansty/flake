inputs: {
  modules = [
    inputs.wsl.nixosModules.default
    ../../commandLine-desktop
    ./ssh-agent.nix
    ../../services/remote-builder.nix
    {
      wsl.enable = true;
      wsl.defaultUser = "clansty";
      users.mutableUsers = false;
      users.allowNoPasswordLogin = true;
    }
  ];
}
