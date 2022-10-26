{ pkgs, config, ... }:
{
  services.karabiner-elements.enable = true;
  programs.nix-index.enable = true;
  programs.man.enable = true;
  environment.systemPackages = with pkgs; with config.nur.repos; [
    openssh
    vscode
    iterm2
    jetbrains.webstorm jetbrains.idea-ultimate
    inkscape-icon
    postman navicat
    stats alt-tab
    tdesktop-mac
    typora-crack
    qspace-pro
    iproute2mac
    pkgs.jdk11
    balena-etcher
    yesplaymusic discord-electron
    zstd
    (
      let hmcl = YisuiMilena.hmcl-bin;
      in
      darwinHelper.wrapApplication {
        name = "HMCL";
        icon = "${hmcl}/share/icons/hicolor/48x48/apps/hmcl.png";
        exec = "${hmcl}/bin/hmcl-bin";
      }
    )
  ];
}
