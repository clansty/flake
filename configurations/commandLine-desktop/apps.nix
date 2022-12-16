{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    nmap nali
    rclone clansty-pb
    rnix-lsp
    picocom
    nodePackages.http-server nodePackages.asar
    azure-cli wrangler
    python310Packages.ipython
    pdftk
    nrb gacp
    python3 nodejs
    deploy-rs.deploy-rs
    openssl
    ffmpeg
    binwalk squashfsTools
    pacman
  ];
}
