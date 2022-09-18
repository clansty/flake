{ ... }:
{
  networking.firewall.enable = false;

  services.avahi = {
    enable = true;
    nssmdns = true;
    reflector = true;
    publish = {
      enable = true;
      addresses = true;
      hinfo = true;
    };
  };
}
