{ config, pkgs, ... }:

{
    users.users.clansty = {
        isNormalUser = true;
        description = "Clansty Icaria";
        extraGroups = [ 
            "wheel" 
            "docker"
            "audio" 
            "sound" 
            "video" 
            "networkmanager" 
            "input" 
            "tty" 
            "libvirt"
        ];
        shell = pkgs.fish;
    };

    security.sudo.extraRules = [
        {
            users = [ "clansty" ];
            commands = [
                {
                    command = "ALL";
                    options = [ "NOPASSWD" ];
                }
            ];
        }
    ];
}
