{ config, pkgs, ... }:

{
  i18n = {
    inputMethod = {
      # 使用 nushell 作为登录 shell 会导致 environment.variables 也就是 /etc/profile 没有被加载，输入法不生效
      enabled = "fcitx5";
      fcitx5 = {
        waylandFrontend = true;
        addons = with pkgs; [
          fcitx5-chinese-addons
        ];
      };
    };
  };
}
