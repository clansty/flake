{ config, pkgs, ... }:

{
  virtualisation = {
    docker.enable = true;
    waydroid.enable = true;
    spiceUSBRedirection.enable = true;
    libvirtd = {
      enable = true;
    };
  };
}
