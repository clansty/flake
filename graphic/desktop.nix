{ config, pkgs, ... }:

{
    services.xserver={
        enable = true;
        layout = "us";
        desktopManager.gnome.enable = true;
    };

    environment.systemPackages = with pkgs.gnomeExtensions; [
        tray-icons-reloaded
        dock-from-dash
    ];

    sound.enable = true;
    hardware.pulseaudio.enable = true;
}