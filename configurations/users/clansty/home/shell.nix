{ pkgs, ... }:
{
  programs.zsh = {
    enable = true;
    history.ignoreSpace = true;
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "sudo" "macos" ];
    };
    enableAutosuggestions = true;
    initExtra = with pkgs;
      ''
        source ${zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
        source ${../../../dotfiles/p10k.zsh}
        source ${zsh-fast-syntax-highlighting}/share/zsh/site-functions/fast-syntax-highlighting.plugin.zsh
        bindkey '^[[1;3D' backward-word
        bindkey '^[[1;3C' forward-word
        zstyle ':completion:*' matcher-list ''' 'm:{a-zA-Z-_}={A-Za-z_-}'
        eval "$(${direnv}/bin/direnv hook zsh)"
        # Tmux ssh fix
        if test "$SSH_CLIENT" ; then
            export SSH_AUTH_SOCK=$HOME/.ssh/ssh_auth_sock
        fi
      '' + (if pkgs.system == "aarch64-darwin" then ''
        eval $(/opt/homebrew/bin/brew shellenv)
      '' else "");
    localVariables = with pkgs;{
      ZSH_AUTOSUGGEST_STRATEGY = "history completion";
    };
  };

  programs.fish.enable = true;

  home = with pkgs;{
    sessionVariables = {
      EDITOR = "${neovim}/bin/nvim";
      SUDO_EDITOR = "${neovim}/bin/nvim";
    };
    shellAliases = {
      ":q" = "exit";
      ":wq" = "exit";
      ls = "${exa}/bin/exa --color-scale --group-directories-first --time-style iso -bH";
      l = "ls -l";
      ll = "l";
      la = "l -a";
      nrbu = "nrb --recreate-lock-file";
      vm = "ssh dev-vm -t -- tmux a";
    } // (if pkgs.system == "aarch64-darwin" then {
      lsblk = "diskutil list";
      finder = "ofd";
      docker = "lima nerdctl";
    } else { });
  };
}
