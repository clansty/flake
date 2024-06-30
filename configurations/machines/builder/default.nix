inputs: {
  modules = [
    ({ modulesPath, ... }: modulesPath + "/virtualisation/proxmox-lxc.nix")
    ../../services/ssh.nix
  ];
}
