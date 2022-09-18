{ pkgs, ... }:
{
  programs = {
    adb.enable = true;
    java = {
      enable = true;
      package = pkgs.jdk11;
    };
  };
  virtualisation.docker.enable = true;
  environment.systemPackages = with pkgs; [
    usbutils pciutils binutils
    traceroute
  ];
}
