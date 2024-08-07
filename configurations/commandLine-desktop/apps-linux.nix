{ pkgs, ... }:
{
  programs = {
    adb.enable = true;
    java = {
      enable = true;
      package = pkgs.jdk11;
    };
  };
  services.fwupd.enable = true;
  environment.systemPackages = with pkgs; [
    usbutils pciutils binutils tcpdump
    traceroute
  ];
  virtualisation.docker.enable = true;
}
