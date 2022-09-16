{ pkgs, ... }:
{
  programs.zsh = {
    enable = true;
    ohMyZsh = {
      enable = true;
      plugins = [ "git" "sudo" ];
    };
    autosuggestions = {
      enable = true;
      async = true;
    };
    promptInit = ''
      source ${pkgs.zsh-fast-syntax-highlighting}/share/zsh/site-functions/fast-syntax-highlighting.plugin.zsh
      source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
      source ${../dotfiles/p10k.zsh}
      bindkey '^[[1;3D' backward-word
      bindkey '^[[1;3C' forward-word
      eval "$(${pkgs.direnv}/bin/direnv hook zsh)"
    '';
  };

  programs.fish.enable = true;

  environment = {
    localBinInPath = true;
    homeBinInPath = true;
    variables = {
      EDITOR = "nvim";
      HYPHEN_INSENSITIVE = "true";
    };
    shellAliases = {
      ":q" = "exit";
      ":wq" = "exit";
      ls = "exa --color-scale --group-directories-first --time-style iso -bH";
      l = "ls -l";
      ll = "l";
      la = "l -a";
      vi = "nvim";
      svi = "sudo nvim";
      nrbu = "nrb --upgrade-all --recreate-lock-file";
    };
  };
}
