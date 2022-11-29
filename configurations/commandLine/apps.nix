{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    neovim direnv
    wget file tree htop
    unrar unzip
    duf gdu
    hyfetch
  ];
}
