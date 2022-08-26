{ config, pkgs, ... }:

{
  fonts = {
    enableDefaultFonts = true;
    fontconfig = {
      enable = true;
      defaultFonts.emoji = [ "Twemoji" "Noto Color Emoji" ];
      defaultFonts.monospace = [ "SF Mono" "PingFang SC" "PingFang HK" "PingFang TC" ];
      defaultFonts.sansSerif = [ "SF Pro Text" "PingFang SC" "PingFang HK" "PingFang TC" ];
      defaultFonts.serif = [ "Noto Serif" "Noto Serif CJK SC" "Noto Serif CJK TC" "Noto Serif CJK JP" ];
    };
    fontDir.enable = true;
    enableGhostscriptFonts = true;
    fonts = (with pkgs; [
      nerdfonts
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
      source-han-mono
      source-han-sans
      source-han-sans-simplified-chinese
      source-han-serif
      source-han-serif-simplified-chinese
      wqy_microhei
      wqy_zenhei
      san-francisco
      meslo-lg
    ]) ++ (with config.nur.repos; [
      rewine.ttf-ms-win10
    ]);
  };
}