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
      source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
      source ${../dotfiles/p10k.zsh}
      export SSH_AUTH_SOCK=/run/user/$UID/gnupg/S.gpg-agent.ssh
    '';
    syntaxHighlighting.enable = true;
  };

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
    };
  };
}
