{ config, pkgs, lib, modulesPath, inputs, ... }:

{
    nix = {
        binaryCaches = [ 
            "https://mirrors.bfsu.edu.cn/nix-channels/store" 
        ];
        package = pkgs.nixFlakes;
        extraOptions = "experimental-features = nix-command flakes";
    };

    time.timeZone = "Asia/Shanghai";

    nixpkgs.config.allowUnfree = true;
    nixpkgs.overlays = [ inputs.sauricat.overlays.sauricat ];

    environment.systemPackages = with pkgs; [
        tdesktop
        neovim 
        wget
        vscode
        jdk
        git
        ark
        kleopatra
        nodejs
        unrar
        unzip
        google-chrome
        exa
        duf
        gnome.gnome-tweaks
        direnv
        hyfetch
    ];

    system.stateVersion = "22.05";
}
