{ ... }:
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
        rev = "64088ff52856f1c322cd3a2664fb616fc4098b43";
      } + "/";
    };
  };
}
