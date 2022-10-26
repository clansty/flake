{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    neovim direnv
    wget file tree htop
    unrar unzip
    duf gdu
    hyfetch
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
  ];
}
