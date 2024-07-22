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
    gnome-extension-manager
  ]);

  hardware.pulseaudio.enable = true;
  qt5.platformTheme = "gnome";
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  nixpkgs.overlays = [
    (
      final: prev: {
        gnome = prev.gnome.overrideScope (gfinal: gprev: {
          mutter = gprev.mutter.overrideAttrs (oldAttrs: {
            patches = [
              ./mutter-text-input-v1.patch
            ];
          });
        });
      }
    )
  ];
}
