{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    nmap nali dogdns
    rclone clansty-pb
    nil
    picocom
    nodePackages.http-server nodePackages.asar
    azure-cli
    python310Packages.ipython
    pdftk
    nrb gacp
    python3 nodejs_22 bun deno corepack_22
    deploy-rs
    openssl
    ffmpeg
    binwalk squashfsTools
    pacman
    kanidm
    gnupg
    nix-output-monitor nixpkgs-fmt
    nix-prefetch-github nix-prefetch-git
  ];
}
