{ pkgs, lib, ... }:
{
  environment.systemPackages = with pkgs; [
    direnv
    file tree htop
    unrar
    duf gdu ripgrep fd
    hyfetch
    socat
  ];

  programs.fish.enable = true;
  programs.nix-index-database.comma.enable = true;
}
