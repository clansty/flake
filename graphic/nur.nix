{ config, pkgs, ... }:

{
  environment.systemPackages = with config.nur.repos; [
    linyinfeng.icalingua-plus-plus
    linyinfeng.wemeet
    rewine.typora-legacy
    rewine.landrop
    linyinfeng.clash-for-windows
    rewine.aliyunpan
    (xddxdd.wine-wechat.override {
      sha256 = "E0ZGFVp9h42G3iMzJ26P7WiASSgRdgnTHUTSRouFQYw=";
    })
  ];
}
