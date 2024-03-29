{ inputs, flake, pkgs, config, homeOnly ? false, ... }:
{
  home.username = "clansty";

  imports = [
    ./git.nix
    ./ssh.nix
    ./shell.nix
    ./nvim.nix
    ./tmux.nix
  ];

  home.stateVersion = "22.11";

  nixpkgs.overlays = [
    inputs.sauricat.overlays.sauricat
    flake.overlays.clansty
    inputs.deploy-rs.overlay
  ];

  nix =
    let
      substituters = [
        # "https://mirrors.bfsu.edu.cn/nix-channels/store/"
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
      deploy-rs.deploy-rs
    ] else [ ]) ++
    (if homeOnly then with pkgs;[
      hyfetch
      rnix-lsp
      direnv
      gacp
    ] else [ ]);
}
