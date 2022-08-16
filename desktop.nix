{ config, pkgs, ... }:

{
    services.xserver={
        enable = true;
        layout = "us";
        displayManager.sddm = {
            enable = true;
            theme = pkgs.sddm-sugar-candy + "/share/sddm/themes/sugar-candy";
            # settings.Theme.CursorTheme = pkgs.bibata-cursors;
        };
        desktopManager.gnome.enable = true;
    };

    sound.enable = true;
    hardware.pulseaudio.enable = true;

    environment.systemPackages = with pkgs.gnomeExtensions; [
        netspeed
        tray-icons-reloaded
        ssh-tray
        dock-from-dash
    ];
}