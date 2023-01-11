{ secrets, inputs, ... }:
{
  imports = [ inputs.netease-music-sync.nixosModules.default ];
  services.netease-music-sync = {
    enable = true;
    cookie = secrets.neteaseCookie;
    download-dir = "/mnt/shares/Music";
    playlists = "605073973,7395387881,2516865753";
  };
}
