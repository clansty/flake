{ config, pkgs, ... }:

{
  programs.steam.enable = true;
  environment.systemPackages = (with pkgs; [
    xivlauncher-cn
    jetbrains.webstorm
    (microsoft-edge.override { commandLineArgs = "--enable-wayland-ime"; })
    warp-terminal
  ]) ++ (with config.nur.repos; [
  ]);
}
