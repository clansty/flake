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

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    vimAlias = true;
    viAlias = true;
    configure.customRC = lib.fileContents ../dotfiles/init.vim;
  };

  programs.zsh.enable = true;
}
