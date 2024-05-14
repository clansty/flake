{ config, pkgs, lib, isLinux, ... }@args:

{
  home-manager.extraSpecialArgs = with args;{
    inherit inputs flake;
    homeOnly = false;
    profileName = "nixos";
  };
  home-manager.users.clansty = import ./home;

  users.users.clansty = {
    shell = pkgs.zsh;
    description = "Clansty Icaria";
  } // lib.attrsets.optionalAttrs isLinux {
    isNormalUser = true;
    extraGroups = [
      "docker"
      "networkmanager"
      "libvirt"
      "input"
    ];
    openssh.authorizedKeys.keys = [
      "ecdsa-sha2-nistp521 AAAAE2VjZHNhLXNoYTItbmlzdHA1MjEAAAAIbmlzdHA1MjEAAACFBAFYdT9p8wZtN+l6CpGmHsaGtPBcxyXJtUcrCe2/lrrzVN4a4opAuNI6qXBA3rld7oL4XPIpiH07J/3FpjTWldsOCQHdGA02K5JWqMGcVVGayLq4FJBlt9gVRkeF7xnPPJq+uy5l5lbj1Rtxd+b1G51bezWCnQ7MoDloO9OIprwyotRXYg== cardno:15 598 150"
    ];
  };
}
