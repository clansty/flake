{ config, pkgs, ... }:

{
    programs.steam.enable = true;
    environment.systemPackages = with pkgs; [
        gnome.gnome-tweaks
        tdesktop
        vscode
        kleopatra
        google-chrome
        yesplaymusic
    ];
}