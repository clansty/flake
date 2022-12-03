{
  services.nginx = {
    enable = true;
    virtualHosts."next.pacman.ltd" = {
      default = true;
      enableACME = true;
      forceSSL = true;
      kTLS = true;
      serverAliases = [ "repo-dispatcher.home.net.men.ci" "repo-dispatcher.net.men.ci" ];
      root = "/pkgbuilder-work/repo";
      extraConfig = ''
        autoindex on;
        autoindex_exact_size off;
        autoindex_localtime on;
      '';
      locations = {
        "/logs/".alias = "/pkgbuilder-work/logs/";
      };
    };
  };
  security.acme = {
    acceptTerms = true;
    defaults = {
      email = "i@gao4.pw";
    };
  };
}
