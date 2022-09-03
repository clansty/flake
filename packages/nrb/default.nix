{ bash
, git
, nixos-rebuild
, writeScriptBin
, ...
}:
writeScriptBin "nrb"
  ''
    #!${bash}/bin/bash
    cd /etc/nixos
    ${git}/bin/git add .
    sudo ${nixos-rebuild}/bin/nixos-rebuild switch -v -L $*
  ''