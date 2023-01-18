{ config, ... }:
{
  services.aria2 = {
    enable = true;
    downloadDir = "/mnt/shares/Downloads";
    rpcSecret = "a";
    extraArguments = "--rpc-listen-port=6800 --continue=true --max-concurrent-downloads=5 --split=16 --min-split-size=1M --max-connection-per-server=16 --disable-ipv6=false --max-tries=5 --rpc-listen-all --remote-time=true";
  };

  systemd.tmpfiles.rules = [
    "d '${config.services.aria2.downloadDir}' 0777 aria2 aria2 - -"
  ];
}
