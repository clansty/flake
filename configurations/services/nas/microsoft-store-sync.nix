{ inputs, ... }:
{
  imports = [ inputs.microsoft-store-sync.nixosModules.default ];
  services.microsoft-store-sync = {
    enable = true;
    config = {
      packages = [
        {
          id = "9WZDNCRFJBMP";
          dir = "store";
        }
        {
          url = "https://www.microsoft.com/en-us/microsoft-365/p/word/cfq7ttc0k7c7";
          dir = "office";
        }
        {
          id = "9PC000G9HGQ2";
          dir = "classtools";
        }
        {
          id = "9PFHDD62MXS1";
          dir = "applemusic";
        }
      ];
      basedir = "/mnt/shares/Appx";
      aria2 = {
        host = "127.0.0.1";
        port = 6800;
        auth.secret = "a";
      };
    };
  };
}
