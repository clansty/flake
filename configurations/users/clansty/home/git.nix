{ ... }:
{
  programs.git = {
    enable = true;
    userName = "Clansty";
    userEmail = "i@gao4.pw";
    signing.key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBG81MB+43JkHMqkjD4RsdFdvF12RVNkPlCbGz9ynaP4";
    signing.signByDefault = true;
    extraConfig = {
      init.defaultBranch = "main";
      credential.helper = "store";
      pull.rebase = false;
      gpg.format = "ssh";
    };
  };
}
