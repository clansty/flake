{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    vscode
    iterm2
    jetbrains.webstorm
  ];
}
