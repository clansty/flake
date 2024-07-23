{ pkgs, lib, ... }:
{
  environment.systemPackages = with pkgs; [
    direnv
    wget file tree htop
    unrar unzip
    duf gdu ripgrep fd
    hyfetch
    socat
  ];

  programs.fish.enable = true;
  programs.nix-index-database.comma.enable = true;
}
