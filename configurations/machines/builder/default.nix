inputs: {
  modules = [
    ({ modulesPath, ... }: { imports = [ (modulesPath + "/virtualisation/proxmox-lxc.nix") ]; })
    ../../services/remote-builder.nix
    inputs.nixos-generators.nixosModules.all-formats
  ];
}
