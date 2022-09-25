{ ... }:
{
  services.samba = {
    enable = true;
    securityType = "user";
    shares = {
      home = {
        path = "/home/clansty";
        browseable = "yes";
        "read only" = "no";
        "guest ok" = "no";
        "create mask" = "0644";
        "directory mask" = "0755";
        "force user" = "clansty";
        "force group" = "users";
      };
    };
  };
}
