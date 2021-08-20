{ config, pkgs, ... }:

{
    services = {
        openssh.enable = true;
        mongodb = {
            enable = true;
            package = pkgs.mongodb;
        };
        flatpak.enable = true;
    };
    programs.gnupg.agent = {
        enable = true;
        enableSSHSupport = true;
    };

}