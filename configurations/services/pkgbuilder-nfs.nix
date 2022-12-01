{
  fileSystems = {
    "/pkgbuilder-work" = {
      device = "172.16.0.70:/mnt/data/pkgbuilder-work";
      fsType = "nfs";
      options = [ "nfsvers=4.2" ];
    };
    "/pkgbuilder-work/logs" = {
      device = "172.16.0.70:/mnt/data/pkgbuilder-work/logs";
      fsType = "nfs";
      options = [ "nfsvers=4.2" ];
    };
    "/pkgbuilder-work/repo" = {
      device = "172.16.0.70:/mnt/data/pkgbuilder-work/repo";
      fsType = "nfs";
      options = [ "nfsvers=4.2" ];
    };
  };
}