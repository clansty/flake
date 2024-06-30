inputs: {
  modules = [
    ({ modulesPath, ... }: modulesPath + "/virtualisation/proxmox-lxc.nix")
    ../../services/remote-builder.nix
  ];
}
