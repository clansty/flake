{ pkgs ? import <nixpkgs> {
    inherit system;
  }
, system ? builtins.currentSystem
, nodejs ? pkgs.nodejs-16_x
}:

let
  nodeEnv = import ./node-env.nix {
    inherit (pkgs) stdenv lib python2 runCommand writeTextFile writeShellScript;
    inherit pkgs nodejs;
    libtool = if pkgs.stdenv.isDarwin then pkgs.darwin.cctools else null;
  };
in
{
  development = import ./node-packages-dev.nix {
    inherit (pkgs) fetchurl nix-gitignore stdenv lib fetchFromGitHub;
    inherit nodeEnv;
  };
}
