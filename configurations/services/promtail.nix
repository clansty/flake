name:
{ secrets, ... }:
{
  services.promtail = {
    enable = true;
    configuration = {
      server = {
        disable = true;
      };
      clients = [{
        url = "https://loki.c5y.moe/loki/api/v1/push";
        basic_auth = secrets.lokiBasicAuth;
      }];
      scrape_configs = [{
        job_name = "journal";
        journal = {
          labels.host = name;
        };
        relabel_configs = [{
          source_labels = [ "__journal__systemd_unit" ];
          target_label = "unit";
        }];
      }];
    };
  };
}
