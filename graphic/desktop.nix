{ config, pkgs, ... }:

{
  services.xserver = {
    enable = true;
    layout = "us";
    desktopManager.gnome = {
      enable = true;
      extraGSettingsOverrides = ''
        [org.gnome.mutter]
        experimental-features=['scale-monitor-framebuffer' 'x11-randr-fractional-scaling']
      '';
      extraGSettingsOverridePackages = [ pkgs.gnome.mutter ];
    };
    excludePackages = with pkgs; [
      xterm
      gnome-connections
      eolie
    ];
  };

  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-kde ];

  environment.systemPackages = (with pkgs.gnomeExtensions; [
    tray-icons-reloaded
    dash-to-dock
    system-monitor
    xremap
  ]) ++ (with pkgs; [
    arc-theme
    tela-icon-theme
  ]);

  sound.enable = true;
  hardware.pulseaudio.enable = true;
  qt5.platformTheme = "gnome";
}
