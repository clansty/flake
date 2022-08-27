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
      sha256 = "0QLki+wjGt+sy0ZAAy/M6TDe4w/JUQPiCqxmipeDbUA=";
    })
  ];
}
