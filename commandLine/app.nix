{ pkgs, ... }:
{
  programs = {
    java.enable = true;
    git = {
      enable = true;
      config = {
        init.defaultBranch = "main";
        user = {
          email = "i@gao4.pw";
          name = "Clansty";
          signingkey = "DFE7C05195DA2F2BF14481CF3A6BE8BAF2EDE134";
        };
        credential.helper = "store";
        pull.rebase = false;
      };
    };
  };
  environment.systemPackages = with pkgs; [
    neovim
    wget
    nodejs
    unrar
    unzip
    exa
    duf
    direnv
    hyfetch
    android-tools
    nmap
    nali
    rclone
    rnix-lsp
    htop
  ];
}
