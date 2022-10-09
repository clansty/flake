{ ... }:
let
  moduleLib = builtins.fetchGit {
    url = "ssh://git@github.com/clansty/ctm-record.git";
    rev = "bf1c5b99d7452254327891fc90d09ccceaba24c3";
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
