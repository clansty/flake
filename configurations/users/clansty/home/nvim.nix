{ lib, ... }:
{
  programs.neovim = {
    enable = true;
    vimAlias = true;
    viAlias = true;
    extraConfig = lib.fileContents ../../../dotfiles/init.vim;
  };
}
