{ pkgs, ... }:
{
  programs.zsh = {
    enable = true;
    enableBashCompletion = true;
    ohMyZsh = {
      enable = true;
      plugins = [ "git" "sudo" ];
    };
    autosuggestions.enable = true;
  };

  environment.etc.zlogin.text = with pkgs;
    # zsh-fast-syntax-highlighting 必须在主题之后加载，不然会变鬼畜
    ''
      # source ${zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
      # source ${../p10k.zsh}
      source ${zsh-fast-syntax-highlighting}/share/zsh/site-functions/fast-syntax-highlighting.plugin.zsh
      bindkey '^[[1;3D' backward-word
      bindkey '^[[1;3C' forward-word
      zstyle ':completion:*' matcher-list ''' 'm:{a-zA-Z-_}={A-Za-z_-}'
      eval "$(${direnv}/bin/direnv hook zsh)"
      # Tmux ssh fix
      if test "$SSH_CLIENT" ; then
          export SSH_AUTH_SOCK=$HOME/.ssh/ssh_auth_sock
      fi
    '';
}
