inputs: {
  modules = [
    inputs.wsl.nixosModules.default
    {
      wsl.enable = true;
      wsl.defaultUser = "clansty";
    }
    ../../commandLine-desktop
  ];
}
