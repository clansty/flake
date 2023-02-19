{ secrets, pkgs, ... }:
let
  package = builtins.fetchTarball {
    url = "https://github.com/alist-org/alist/releases/download/v3.11.0/alist-linux-musl-amd64.tar.gz";
    sha256 = "16433zp1y16jyqc7janm55178ds0c2qiy3j2n01glkgh13d8gy1i";
  };
in
{
  users = {
    users.alist = {
      isSystemUser = true;
      createHome = true;
      home = "/var/lib/alist";
      group = "alist";
      description = "alist service";
    };

    groups.alist = { };
  };

  systemd.services.alist = {
    description = "alist service";
    wantedBy = [ "multi-user.target" ];
    after = [ "network.target" ];
    serviceConfig = {
      User = "alist";
      Group = "alist";
      Restart = "on-failure";
      ExecStart = "${package} server --data /var/lib/alist";
      AmbientCapabilities = "cap_net_bind_service";
    };
  };
}
