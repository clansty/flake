{ runCommand
, writeScript
, writeText
, imagemagick
, libicns
, bash
, name
, exec
, icon
}:
let
  runScript = writeScript "run" ''
    #!${bash}/bin/bash

    ${exec}
  '';

  info = writeText "info.plist" ''
    <?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
    <plist version="1.0">
    <dict>
        <key>CFBundleExecutable</key>
        <string>run.sh</string>
        <key>CFBundleIconFile</key>
        <string>icon.icns</string>
    </dict>
    </plist>
  '';
in
runCommand name { } ''
  mkdir -p $out/Applications/${name}.app/Contents/{Resources,MacOS}
  ln -s ${info} $out/Applications/${name}.app/Contents/Info.plist
  ln -s ${runScript} $out/Applications/${name}.app/Contents/MacOS/run.sh
  # convert the icon
  # https://gist.github.com/zlbruce/883605a635df8d5964bab11ed75e46ad
  pwd
  mkdir icon
  ${imagemagick}/bin/convert -background none -resize '!16x16' ${icon} "icon/icon_16x16.png"
  ${imagemagick}/bin/convert -background none -resize '!32x32' ${icon} "icon/icon_16x16@2x.png"
  ${imagemagick}/bin/convert -background none -resize '!128x128' ${icon} "icon/icon_128x128.png"
  ${imagemagick}/bin/convert -background none -resize '!256x256' ${icon} "icon/icon_128x128@2x.png"
  ${imagemagick}/bin/convert -background none -resize '!512x512' ${icon} "icon/icon_256x256@2x.png"
  ${imagemagick}/bin/convert -background none -resize '!1024x1024' ${icon} "icon/icon_512x512@2x.png"
  ${libicns}/bin/png2icns $out/Applications/${name}.app/Contents/Resources/icon.icns icon/*
''
