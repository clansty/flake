{ bash
, git
, writeScriptBin
, stdenv
, pkgs
, ...
}:
if stdenv.isLinux then
  writeScriptBin "nrb"
    ''
      #!${bash}/bin/bash
      sudo nixos-rebuild switch --flake path:$HOME/nixos --log-format internal-json -v -L $* |& ${pkgs.nix-output-monitor}/bin/nom --json
    ''
else
  writeScriptBin "nrb"
    ''
      #!${bash}/bin/bash
      cd ~/.nixpkgs
      ${git}/bin/git add .
      cd $TMPDIR
      darwin-rebuild switch --flake ~/.nixpkgs -v -L $*
    ''
