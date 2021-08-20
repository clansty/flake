{ config, pkgs, ... }:

{
    virtualisation = {
        docker.enable = true;
        spiceUSBRedirection.enable = true;
        libvirtd = {
            enable = true;
        };
    };
}
