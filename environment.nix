{ config, pkgs, lib, modulesPath, inputs, ... }:

{
    nix = {
        settings.substituters = [ 
            "https://mirrors.bfsu.edu.cn/nix-channels/store" 
        ];
        package = pkgs.nixFlakes;
        extraOptions = "experimental-features = nix-command flakes";
    };

    time.timeZone = "Asia/Shanghai";

    nixpkgs.config.allowUnfree = true;
    nixpkgs.overlays = [ inputs.sauricat.overlays.sauricat ];

    environment.systemPackages = with pkgs; [
        neovim 
        wget
        jdk
        git
        nodejs
        unrar
        unzip
        exa
        duf
        direnv
        hyfetch
    ];

    system.stateVersion = "22.05";
}
