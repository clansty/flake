{ ... }:
let
  moduleLib = builtins.fetchGit {
    url = "ssh://git@github.com/clansty/ctm-record.git";
    rev = "1af2b05cbc68dffdf007be44fe071ab53e9e4db0";
  };
in
{ 
  imports = [ "${moduleLib}/nixos/module.nix" ];
  services.ctm-record = {
    enable = true;
    database = "postgresql://ctm:passwd@127.0.0.1:5432/ctm?schema=public";
    port = 8081;
  };
}
