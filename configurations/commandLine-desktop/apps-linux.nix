{ pkgs, ... }:
{
  programs = {
    adb.enable = true;
    java = {
      enable = true;
      package = pkgs.jdk11;
    };
    ssh.startAgent = true;
  };
  environment.systemPackages = with pkgs; [
    usbutils pciutils binutils dnsutils tcpdump
    traceroute
  ];
}
