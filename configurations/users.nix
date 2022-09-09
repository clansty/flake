{ config, pkgs, ... }:

{
  users.defaultUserShell = pkgs.zsh;
  users.users.clansty = {
    isNormalUser = true;
    description = "Clansty Icaria";
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

  security.sudo.extraRules = [
    {
      users = [ "clansty" ];
      commands = [
        {
          command = "ALL";
          options = [ "NOPASSWD" ];
        }
      ];
    }
  ];

  security.polkit.extraConfig = ''
    /* Allow members of the wheel group to execute any actions
    * without password authentication, similar to "sudo NOPASSWD:"
    */
    polkit.addRule(function(action, subject) {
        if (subject.isInGroup("wheel")) {
            return polkit.Result.YES;
        }
    });
  '';
}
