{ config, pkgs, ... }:

{
  i18n = {
    inputMethod = {
      enabled = "fcitx5";
      fcitx5 = {
        waylandFrontend = true;
        addons = [
          pkgs.fcitx5-chinese-addons
        ];
      };
    };
  };
}
