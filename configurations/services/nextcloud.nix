{ secrets, pkgs, ... }:
{
  services.nextcloud = {
    enable = true;
    https = true;
    datadir = "/mnt/data/nextcloud";
    hostName = "clansty-nextcloud.net.men.ci";
    config = {
      dbtype = "pgsql";
      dbhost = "172.16.0.82";
      dbpassFile = "${pkgs.writeText "passwd" secrets.nextcloudDbPasswd}";
      adminuser = "ncadmin1";
      adminpassFile = "${pkgs.writeText "passwd" secrets.nextcloudDbPasswd}";
      overwriteProtocol = "https";
      extraTrustedDomains = [ "clansty-nextcloud.home.net.men.ci" ];
    };
    maxUploadSize = "40960M";
    autoUpdateApps.enable = true;
  };

  services.nginx.package = pkgs.nginxQuic;
  services.nginx.virtualHosts."clansty-nextcloud.net.men.ci" = {
    kTLS = true;
    http3 = true;
    forceSSL = true;
    enableACME = true;
    serverAliases = [ "clansty-nextcloud.home.net.men.ci" ];
  };

  security.acme = {
    acceptTerms = true;
    defaults = {
      email = "i@gao4.pw";
    };
  };
}