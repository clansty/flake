{ config, pkgs, ... }:

{
  services.xserver = {
    enable = true;
    layout = "us";
    desktopManager.gnome = {
      enable = true;
    };
    excludePackages = with pkgs; [
      xterm
    ];
  };

  environment.gnome.excludePackages = (with pkgs; [
    gnome-tour
    gnome-connections
    eolie
  ]) ++ (with pkgs.gnome; [
    epiphany
  ]);

  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-kde ];

  environment.systemPackages = (with pkgs.gnomeExtensions; [
    appindicator
    dash-to-dock
    system-monitor-next
    xremap
  ]) ++ (with pkgs; [
    arc-theme
    tela-icon-theme
  ]);

  sound.enable = true;
  hardware.pulseaudio.enable = true;
  qt5.platformTheme = "gnome";
}
