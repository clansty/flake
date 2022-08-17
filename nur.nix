{config, pkgs, ...}:

{
    environment.systemPackages = with config.nur.repos; let 
        wechat=xddxdd.wine-wechat.override{
            sha256="0QLki+wjGt+sy0ZAAy/M6TDe4w/JUQPiCqxmipeDbUA=";
        }; in [
            linyinfeng.icalingua-plus-plus
            linyinfeng.wemeet
            wechat
        ];
}