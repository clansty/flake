{ pkgs, ... }:
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
      locations."/ariang/".alias = pkgs.fetchzip {
        url = "https://github.com/mayswind/AriaNg/releases/download/1.2.4/AriaNg-1.2.4.zip";
        sha256 = "TID8r5M4bCLg3d7J8nb7/hDRMj1U1FbGjccu1PdKJRg=";
        stripRoot = false;
      } + "/";
    };
  };
}
