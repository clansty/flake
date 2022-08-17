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
  };

  environment.systemPackages = with pkgs.gnomeExtensions; [
    tray-icons-reloaded
    dock-from-dash
  ];

  sound.enable = true;
  hardware.pulseaudio.enable = true;
}
