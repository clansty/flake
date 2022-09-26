{ pkgs, ... }:
{
  programs.zsh = {
    enable = true;
    interactiveShellInit = with pkgs; ''
      plugins=(git sudo)
      source ${oh-my-zsh}/share/oh-my-zsh/oh-my-zsh.sh
      source ${zsh-autosuggestions}/share/zsh-autosuggestions/zsh-autosuggestions.zsh
      source ${zsh-fast-syntax-highlighting}/share/zsh/site-functions/fast-syntax-highlighting.plugin.zsh
      source ${zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
      source ${../dotfiles/p10k.zsh}
      bindkey '^[[1;3D' backward-word
      bindkey '^[[1;3C' forward-word
      setopt autocd
      zstyle ':completion:*' matcher-list ''' 'm:{a-zA-Z-_}={A-Za-z_-}'
      eval "$(${direnv}/bin/direnv hook zsh)"
      alias ls='${exa}/bin/exa --color-scale --group-directories-first --time-style iso -bH'
    '';
  };

  programs.fish.enable = true;

  environment = {
    variables = {
      EDITOR = "nvim";
      ZSH_AUTOSUGGEST_STRATEGY = "history completion";
    };
    shellAliases = {
      ":q" = "exit";
      ":wq" = "exit";
      ls = "${pkgs.exa}/bin/exa --color-scale --group-directories-first --time-style iso -bH";
      l = "ls -l";
      ll = "l";
      la = "l -a";
      vi = "nvim";
      svi = "sudo nvim";
      nrbu = "nrb --upgrade-all --recreate-lock-file";
    };
  };
}
