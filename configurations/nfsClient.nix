{ ... }: 
{
  fileSystems."/run/media/clansty/nasShares" = {
    device = "172.16.0.70:/mnt/data/shares";
    fsType = "nfs";
    options = [ "nfsvers=4.2" "nofail" ];
  };

  fileSystems."/run/media/clansty/nasBackups" = {
    device = "172.16.0.70:/mnt/data/backups";
    fsType = "nfs";
    options = [ "nfsvers=4.2" "nofail" ];
  };
}