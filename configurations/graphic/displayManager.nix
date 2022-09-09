{ config, pkgs, ... }:

{
    services.xserver.displayManager.gdm = {
        enable = true;
        autoSuspend = false;
    };
    # services.xserver.displayManager.sddm = {
    #     enable = true;
    #     theme = pkgs.sddm-sugar-candy + "/share/sddm/themes/sugar-candy";
    #     settings.Theme.CursorTheme = "Bibata-Modern-Amber";
    # };
    environment.systemPackages = with pkgs; [
        libsForQt5.qt5.qtgraphicaleffects
        bibata-cursors
    ];
}