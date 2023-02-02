{
  fileSystems = {
    "/pkgbuilder-work" = {
      device = "11.11.1.5:/data/pkgbuilder-work";
      fsType = "nfs";
      options = [ "nfsvers=4.2" ];
    };
    "/pkgbuilder-work/logs" = {
      device = "11.11.1.5:/data/pkgbuilder-work/logs";
      fsType = "nfs";
      options = [ "nfsvers=4.2" ];
    };
    "/pkgbuilder-work/mirrors/archlinuxarm" = {
      device = "11.11.1.5:/data/mirrors/archlinuxarm";
      fsType = "nfs";
      options = [ "nfsvers=4.2" ];
    };
  };
}