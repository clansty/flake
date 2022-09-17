{ config, pkgs, lib, isLinux, ... }:

{
  imports = [
    ./git.nix
    ./ssh.nix
  ];
  home-manager.users.clansty.home.stateVersion = "22.11";

  users.users.clansty = {
    shell = pkgs.zsh;
    description = "Clansty Icaria";
  } // lib.attrsets.optionalAttrs isLinux {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "docker"
      "networkmanager"
      "libvirt"
      "input"
    ];
    openssh.authorizedKeys.keys = [
      "ecdsa-sha2-nistp521 AAAAE2VjZHNhLXNoYTItbmlzdHA1MjEAAAAIbmlzdHA1MjEAAACFBAFYdT9p8wZtN+l6CpGmHsaGtPBcxyXJtUcrCe2/lrrzVN4a4opAuNI6qXBA3rld7oL4XPIpiH07J/3FpjTWldsOCQHdGA02K5JWqMGcVVGayLq4FJBlt9gVRkeF7xnPPJq+uy5l5lbj1Rtxd+b1G51bezWCnQ7MoDloO9OIprwyotRXYg== cardno:15 598 150"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICHJFCPpkca2UyVfDhRhZMC0Mc2N7SoLR6A0GjlXzD8Z termux"
      "sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAII6a+8ryQwFuri1d5O0sTdZbdiv2i//ieu5fJFxQVjd/AAAABHNzaDo="
    ];
  };
}
