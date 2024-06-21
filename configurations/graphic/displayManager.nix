{ config, pkgs, ... }:

{
    services.xserver.displayManager.gdm = {
        enable = true;
        autoSuspend = true;
    };
    # services.displayManager.sddm = {
    #     enable = true;
    #     settings.Theme.CursorTheme = "Bibata-Modern-Amber";
    #     sugarCandyNix.enable = true;
    # };
    environment.systemPackages = with pkgs; [
        libsForQt5.qt5.qtgraphicaleffects
        bibata-cursors
    ];
}
