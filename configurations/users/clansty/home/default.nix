{ inputs, flake, pkgs, config, homeOnly ? false, ... }:
{
  home.username = "clansty";

  imports = [
    ./git.nix
    ./ssh.nix
    ./shell.nix
    ./nvim.nix
    ./tmux.nix
    ./gnupg.nix
  ];

  home.stateVersion = "22.11";

  nixpkgs.overlays = [
    flake.overlays.clansty
  ];

  nix =
    let
      substituters = [
        "https://mirrors.bfsu.edu.cn/nix-channels/store/"
        "https://cache.nixos.org"
      ];
    in
    {
      package = pkgs.lib.mkForce pkgs.nix;
      extraOptions = ''
        experimental-features = nix-command flakes
      '';
      settings.substituters = substituters;
      settings.trusted-substituters = substituters ++ [ "<local-substituter>" ];
    };

  programs.home-manager.enable = true;
  home.packages = with pkgs; [ ] ++
    (if pkgs.system == "aarch64-darwin" then with pkgs;[
      coreutils
    ] else [ ]) ++
    (if pkgs.system == "x86_64-linux" && homeOnly then with pkgs;[
      deploy-rs
    ] else [ ]) ++
    (if homeOnly then with pkgs;[
      hyfetch
      nil
      direnv
      gacp
      nix-output-monitor
    ] else [ ]);
}
