{
  nix.buildMachines = [
    {
      hostName = "wslbuilder";
      systems = [
        "x86_64-linux"
        "i686-linux"
      ];
      maxJobs = 2;
      speedFactor = 2;
      supportedFeatures = [
        "nixos-test"
        "ca-derivations"
        "benchmark"
        "big-parallel"
      ];
      mandatoryFeatures = [ ];
    }
    {
      hostName = "pvebuilder";
      systems = [
        "x86_64-linux"
        "i686-linux"
      ];
      maxJobs = 2;
      speedFactor = 1;
      supportedFeatures = [
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

  programs.ssh.extraConfig = ''
    Host wslbuilder
      Hostname 11.11.3.122
      Port 222
      IdentityFile /root/.ssh/id_ed25519
    Host pvebuilder
      Hostname 11.11.1.15
      Port 222
      IdentityFile /root/.ssh/id_ed25519
  '';
}