{ bash
, git
, writeScriptBin
, stdenv
, ...
}:
if stdenv.isLinux then
  writeScriptBin "nrb"
    ''
      #!${bash}/bin/bash
      cd /etc/nixos
      ${git}/bin/git add .
      sudo nixos-rebuild switch -v -L $*
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
