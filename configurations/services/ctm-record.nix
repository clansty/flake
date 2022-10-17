{ ... }:
let
  moduleLib = builtins.fetchGit {
    url = "ssh://git@github.com/clansty/ctm-record.git";
    rev = "7071f1d87573dd1b50ea2f5e7edba4dc635f6131";
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
