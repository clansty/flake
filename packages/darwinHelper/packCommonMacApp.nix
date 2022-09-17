{ stdenvNoCC
, src
, pname
, version
, meta
}:
stdenvNoCC.mkDerivation {
  inherit pname version meta src;

  installPhase = ''
    runHook preInstall
    mkdir -p $out/Applications
    if [ -d MacWk.com ]; then
      cp -r MacWk.com/*.app $out/Applications
      exit 0
    fi
    if [ -d ./Contents ]; then
      # 针对 zip 里面就一个 .app 结尾的文件夹。这样这个文件夹会被当作 source 目录
      mkdir -p $out/Applications/${pname}.app
      cp -r Contents $out/Applications/${pname}.app
    fi
    for f in *.app; do
      cp -r "$f" $out/Applications
    done
    runHook postInstall
  '';
}
