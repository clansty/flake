{ config, pkgs, isLinux, lib, inputs, ... }:

{
  fonts = {
    fontDir.enable = true;
    packages = (with pkgs; [
      (nerdfonts.override {
        fonts = [ "FiraCode" "Hack" "JetBrainsMono" "UbuntuMono" ];
      })
      hack-font
      inter
      liberation_ttf
      twemoji-color-font
      noto-fonts
      noto-fonts-emoji
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      noto-fonts-extra
      roboto
      sarasa-gothic
      source-han-sans
      source-han-serif
      source-han-mono
      wqy_microhei
      wqy_zenhei
      harmonyos-sans
    ]) ++ (with config.nur.repos; [
      rewine.ttf-ms-win10
      humxc.misans
    ]) ++ (lib.lists.optionals isLinux (with pkgs; [
      san-francisco
      meslo-lg
    ]));
  } // lib.attrsets.optionalAttrs isLinux {
    enableGhostscriptFonts = true;
    enableDefaultPackages = true;
    fontconfig = {
      enable = true;
      defaultFonts.emoji = [ "Twemoji" "Noto Color Emoji" ];
      defaultFonts.monospace = [ "SF Mono" "PingFang SC" "PingFang HK" "PingFang TC" ];
      defaultFonts.sansSerif = [ "SF Pro Text" "PingFang SC" "PingFang HK" "PingFang TC" ];
      defaultFonts.serif = [ "Noto Serif" "Noto Serif CJK SC" "Noto Serif CJK TC" "Noto Serif CJK JP" ];
    };
  };
}
