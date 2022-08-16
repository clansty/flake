{ config, pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
        gnome.gnome-tweaks
        tdesktop
        vscode
        kleopatra
        google-chrome
    ];
}