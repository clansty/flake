{ ... }:
let
  moduleLib = builtins.fetchGit {
    url = "ssh://git@github.com/clansty/ctm-record.git";
    rev = "43e45364542865cba8e25357d4959e99db603e51";
  };
in
{
  imports = [ "${moduleLib}/nixos/module.nix" ];
  services.ctm-record = {
    enable = true;
    database = "postgresql://ctm:passwd@127.0.0.1:5432/ctm?schema=public";
    port = 8081;
    cert = ../dotfiles/nix-srv.crt;
    key = (import ../utils/secrets.nix).nixSrvKey;
  };
}
