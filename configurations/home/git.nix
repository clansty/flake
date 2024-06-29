{
  programs.git = {
    enable = true;
    userName = "Clansty";
    userEmail = "i@gao4.pw";
    signing.key = "DFE7C05195DA2F2BF14481CF3A6BE8BAF2EDE134";
    signing.signByDefault = false;
    extraConfig = {
      init.defaultBranch = "main";
      credential.helper = "store";
      pull.rebase = false;
    };
  };
}
