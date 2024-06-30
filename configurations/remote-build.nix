{
  nix.buildMachines = [
    {
      hostName = "11.11.3.122";
      systems = [
        "x86_64-linux"
        "i686-linux"
      ];
      maxJobs = 4;
      speedFactor = 2;
      supportedFeatures = [
        "kvm"
        "nixos-test"
        "ca-derivations"
        "benchmark"
        "big-parallel"
      ];
      mandatoryFeatures = [ ];
    }
  ];
  nix.distributedBuilds = true;
  # Optional, useful when the builder has a faster internet connection than yours
  nix.settings.builders-use-substitutes = true;
}