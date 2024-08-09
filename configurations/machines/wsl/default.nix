inputs: {
  modules = [
    inputs.wsl.nixosModules.default
    ../../commandLine-desktop
    ./ssh-agent.nix
    ../../services/remote-builder.nix
    ({ pkgs, ... }: {
      wsl.enable = true;
      wsl.defaultUser = "clansty";
      users.mutableUsers = false;
      users.allowNoPasswordLogin = true;
      users.users.clansty.shell = pkgs.nushell;
    })
  ];
}
