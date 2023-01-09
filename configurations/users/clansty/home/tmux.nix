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
    '';
  };
}
