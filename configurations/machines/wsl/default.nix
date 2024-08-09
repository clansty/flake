inputs: {
  modules = [
    inputs.wsl.nixosModules.default
    ../../commandLine-desktop
    ./ssh-agent.nix
    ../../services/remote-builder.nix
    ({ pkgs, lib, ... }: {
      wsl.enable = true;
      wsl.defaultUser = "clansty";
      users.mutableUsers = false;
      users.allowNoPasswordLogin = true;
      users.users.clansty.shell = lib.mkForce pkgs.nushell;
    })
  ];
}
