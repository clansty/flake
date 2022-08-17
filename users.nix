{ config, pkgs, ... }:

{
  users.users.clansty = {
    isNormalUser = true;
    description = "Clansty Icaria";
    extraGroups = [
      "wheel"
      "docker"
      "audio"
      "sound"
      "video"
      "networkmanager"
      "input"
      "tty"
      "libvirt"
    ];
    shell = pkgs.zsh;
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
