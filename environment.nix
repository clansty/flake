{ config, pkgs, ... }:

{
    nix.binaryCaches = [ 
        "https://mirrors.bfsu.edu.cn/nix-channels/store" 
    ];

    time.timeZone = "Asia/Shanghai";

    nixpkgs.config.allowUnfree = true;

    environment.systemPackages = with pkgs; [
        vim 
        wget
        vscode
        jdk
        git
        ark
        kate
        screenfetch
        neofetch
        kleopatra
        nodejs
        pythonFull
        unrar
        unzip
        typora
        appimagekit
        gcc
    ];

    system.stateVersion = "21.05";
}
