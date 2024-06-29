{ pkgs, lib, ... }:
{
  environment.systemPackages = with pkgs; [
    direnv
    wget file tree htop
    unrar unzip
    duf gdu ripgrep
    hyfetch
    socat
  ];

  programs.fish.enable = true;
}
