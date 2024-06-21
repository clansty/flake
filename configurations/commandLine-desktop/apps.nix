{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    nmap nali
    rclone clansty-pb
    nil
    picocom
    nodePackages.http-server nodePackages.asar
    azure-cli wrangler
    python310Packages.ipython
    pdftk
    nrb gacp
    python3 nodejs
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
