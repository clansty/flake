{ ... }:
let
  moduleLib = builtins.fetchGit {
    url = "ssh://git@github.com/clansty/ctm-record.git";
    rev = "d19ac7e8c5d3fba602ed0d15cf51ccc5815839f1";
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
