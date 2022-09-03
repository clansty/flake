{ pkgs, ... }:
{
  programs = {
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
    adb.enable = true;
    java = { 
      enable = true; 
      package = pkgs.jdk11; 
    };
  };
  environment.systemPackages = with pkgs; [
    neovim
    wget file tree htop usbutils pciutils
    unrar unzip
    exa duf gdu
    hyfetch
    nmap nali traceroute
    rclone clansty-pb
    rnix-lsp
    minicom
    nodePackages.http-server nodePackages.asar
    azure-cli wrangler
    python310Packages.ipython
    pdftk
    ntfs2btrfs
    nrb gacp
  ];
}
