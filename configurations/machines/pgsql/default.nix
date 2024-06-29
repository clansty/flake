inputs: {
  modules = [
    ({ modulesPath, ... }: modulesPath + "/virtualisation/proxmox-lxc.nix")
    ./services/postgres.nix
    ../../services/ssh.nix
  ];
}
