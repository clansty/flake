{ ... }:
{
  networking.firewall.enable = false;

  networking.extraHosts = ''
  '';

  services.avahi = {
    enable = true;
    nssmdns4 = true;
    publish = {
      enable = true;
      addresses = true;
      hinfo = true;
    };
  };
}
