{ pkgs, ... }:
with pkgs;{
  environment = {
    shellAliases = {
      ":q" = "exit";
      ":wq" = "exit";
      ls = "${eza}/bin/eza --color-scale --group-directories-first --time-style iso -bH";
      l = "ls -l";
      ll = "l";
      la = "l -a";
      nrbu = "nrb --recreate-lock-file";
    };

    sessionVariables = {
      EDITOR = "${neovim}/bin/nvim";
      SUDO_EDITOR = "${neovim}/bin/nvim";
      ZSH_AUTOSUGGEST_STRATEGY = "history completion";
    };
  };
}
