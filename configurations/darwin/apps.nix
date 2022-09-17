{ pkgs, ... }:
{
  services.karabiner-elements.enable = true;
  environment.systemPackages = with pkgs; [
    vscode
    iterm2
    jetbrains.webstorm
  ];
}
