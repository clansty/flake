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
    epiphany
  ]);

  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-kde ];

  environment.systemPackages = (with pkgs.gnomeExtensions; [
    appindicator
    dash-to-dock
    system-monitor
    xremap
    blur-my-shell
    kimpanel
  ]) ++ (with pkgs; [
    arc-theme
    tela-icon-theme
    adw-gtk3
  ]);

  hardware.pulseaudio.enable = true;
  qt5.platformTheme = "gnome";

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    GDK_SCALE = "2";
    XCURSOR_SIZE = "48";
    QT_SCALE_FACTOR = "2";
  };

  nixpkgs.overlays = [
    (
      final: prev: {
        gnome = prev.gnome.overrideScope (gfinal: gprev: {
          mutter = gprev.mutter.overrideAttrs (oldAttrs: {
            patches = [
              ./mutter-text-input-v1.patch
              ./xwayland-scaling.patch
              ./mutter-cursor-position-fix.patch
            ];
          });
        });
      }
    )
  ];
}
