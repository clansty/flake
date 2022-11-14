{ inputs, flake, pkgs, ... }:
{
  home.username = "clansty";

  imports = [
    ./git.nix
    ./ssh.nix
  ];

  home.stateVersion = "22.11";

  nixpkgs.overlays = [
    inputs.sauricat.overlays.sauricat
    flake.overlays.clansty
  ];

  nix.package = pkgs.nix;
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  programs.home-manager.enable = true;
  home.packages = with pkgs; [
    coreutils
    rnix-lsp
  ];
}
