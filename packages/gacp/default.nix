{ bash
, git
, writeScriptBin
, ...
}:
writeScriptBin "gacp"
  ''
    #!${bash}/bin/bash
    ${git}/bin/git add .
    ${git}/bin/git commit -m "$*"
    ${git}/bin/git push
  ''