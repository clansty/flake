{ config, pkgs, lib, isLinux, ... }@args:

{
  home-manager.extraSpecialArgs = with args;{
    inherit inputs flake;
    homeOnly = false;
    profileName = "nixos";
  };
  home-manager.users.clansty = import ../../../home;

  users.users.clansty = {
    shell = pkgs.zsh;
    description = "Clansty Icaria";
    isNormalUser = true;
    extraGroups = [
      "docker"
      "networkmanager"
      "libvirt"
      "input"
    ];
  };
}
