{
  fileSystems = {
    "/pkgbuilder-work" = {
      device = "172.16.0.71:/data/pkgbuilder-work";
      fsType = "nfs";
      options = [ "nfsvers=4.2" ];
    };
    "/pkgbuilder-work/logs" = {
      device = "172.16.0.71:/data/pkgbuilder-work/logs";
      fsType = "nfs";
      options = [ "nfsvers=4.2" ];
    };
    "/pkgbuilder-work/mirrors/archlinuxarm" = {
      device = "172.16.0.71:/data/mirrors/archlinuxarm";
      fsType = "nfs";
      options = [ "nfsvers=4.2" ];
    };
  };
}