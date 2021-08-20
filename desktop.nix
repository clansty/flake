{ config, pkgs, ... }:

{
    services.xserver={
        enable = true;
        layout = "us";
        displayManager.sddm.enable = true;
        desktopManager.plasma5.enable = true;
    };

    xdg.portal={
        enable = true;
        extraPortals = [ pkgs.xdg-desktop-portal-gtk ];   
    };

    sound.enable = true;
    hardware.pulseaudio.enable = true;

}