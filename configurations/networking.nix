{ ... }:
{
  networking.firewall.enable = false;

  networking.extraHosts = ''
    172.16.0.81 mb3admin.com
  '';

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
