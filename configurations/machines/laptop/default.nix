inputs: {
  modules = [
    ./hardware.nix
    ./tpm.nix
    ../../boot.nix
    ../../commandLine-desktop
    ../../graphic
    ../../remote-build.nix
  ];
}
