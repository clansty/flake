{ secrets, pkgs, ... }:
{
  services.nextcloud = {
    enable = true;
    https = true;
    datadir = "/mnt/data/nextcloud";
    hostName = "nextcloud.c5y.moe";
    config = {
      dbtype = "pgsql";
      dbhost = "11.11.1.4";
      dbpassFile = "${pkgs.writeText "passwd" secrets.nextcloudDbPasswd}";
      adminuser = "ncadmin1";
      adminpassFile = "${pkgs.writeText "passwd" secrets.nextcloudDbPasswd}";
      overwriteProtocol = "https";
      extraTrustedDomains = [ "clansty-nextcloud.home.net.men.ci" "clansty-nextcloud.net.men.ci" ];
    };
    maxUploadSize = "40960M";
    autoUpdateApps.enable = true;
  };

  environment.systemPackages = with pkgs;[
    nodejs-slim-14_x
    libtensorflow
  ];

  services.nginx.package = pkgs.nginxQuic;
  services.nginx.virtualHosts."nextcloud.c5y.moe" = {
    kTLS = true;
    http3 = true;
    forceSSL = true;
    enableACME = true;
    serverAliases = [ "clansty-nextcloud.home.net.men.ci" "clansty-nextcloud.net.men.ci" ];
  };

  security.acme = {
    acceptTerms = true;
    defaults = {
      email = "i@gao4.pw";
    };
  };
}
