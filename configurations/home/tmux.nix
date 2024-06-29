{
  programs.tmux = {
    enable = true;
    historyLimit = 50000;
    shortcut = "a";
    keyMode = "vi";
    terminal = "tmux-256color";
    baseIndex = 1;
    newSession = true;
    extraConfig = ''
      set-option -g mouse on
      bind -r q select-window -p
      bind -r e select-window -n
      bind n new-window

      set -wg window-status-current-style "bg=yellow"

      # Remove SSH_AUTH_SOCK to disable tmux automatically resetting the variable
      set -g update-environment "DISPLAY SSH_ASKPASS SSH_AGENT_PID \
                                  SSH_CONNECTION WINDOWID XAUTHORITY"

      # Use a symlink to look up SSH authentication
      setenv -g SSH_AUTH_SOCK $HOME/.ssh/ssh_auth_sock
    '';
  };
}
