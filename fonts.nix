{ config, pkgs, ... }:

{
  fonts = {
    enableDefaultFonts = true;
    fontconfig = {
      enable = true;
      defaultFonts.emoji = [ "Twemoji" "Noto Color Emoji" ];
      defaultFonts.monospace = [ "Monaco" "Hack" "Sarasa Mono SC" ];
      defaultFonts.sansSerif = [ "Inter" "Liberation Sans" "Soruce Han Sans SC" ];
      defaultFonts.serif = [ "Liberation Serif" "Source Han Serif SC" ];
    };
    fontDir.enable = true;
    enableGhostscriptFonts = true;
    fonts = with pkgs; [
      hack-font
      inter
      liberation_ttf
      twemoji-color-font
      noto-fonts-emoji
      roboto
      sarasa-gothic
      source-han-mono
      source-han-sans
      source-han-sans-simplified-chinese
      source-han-serif
      source-han-serif-simplified-chinese
      wqy_microhei
      wqy_zenhei
    ];
  };
}