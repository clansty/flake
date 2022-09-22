{ pkgs, config, ... }:
let 
  enablePhp = ''
    location ~ \.php$ {
      fastcgi_split_path_info ^(.+\.php)(/.+)$;
      fastcgi_pass  unix:${config.services.phpfpm.pools.mypool.socket};
      fastcgi_index index.php;
      include ${pkgs.nginx}/conf/fastcgi_params;
      include ${pkgs.nginx}/conf/fastcgi.conf;
      fastcgi_param SCRIPT_FILENAME $request_filename;
    }
  '';
in
{
  services.nginx = {
    enable = true;
    virtualHosts.localhost = {
      root = "/var/www";
      extraConfig = ''
        autoindex on;
        autoindex_exact_size off;
        autoindex_localtime on;
      '';
      locations."/maimai-xck/".alias = builtins.fetchGit {
        url = "ssh://git@github.com/clansty/maimai-xck.git";
        rev = "d1dd34ac25fc3914cedb23ea48fd6b68938a822d";
      } + "/";
      locations."/ariang/".alias = pkgs.fetchzip {
        url = "https://github.com/mayswind/AriaNg/releases/download/1.2.4/AriaNg-1.2.4.zip";
        sha256 = "TID8r5M4bCLg3d7J8nb7/hDRMj1U1FbGjccu1PdKJRg=";
        stripRoot = false;
      } + "/";
      locations."/adminer/"={
        alias = pkgs.adminer + "/";
        extraConfig = enablePhp;
      };
    };
  };
  services.phpfpm.pools.mypool = {
    user = "nobody";
    settings = {
      pm = "dynamic";
      "listen.owner" = config.services.nginx.user;
      "pm.max_children" = 5;
      "pm.start_servers" = 2;
      "pm.min_spare_servers" = 1;
      "pm.max_spare_servers" = 3;
      "pm.max_requests" = 500;
    };
  };
}
