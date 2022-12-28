{ secrets, pkgs, ... }:
let
  package = builtins.fetchTarball {
    url = "https://github.com/alist-org/alist/releases/download/v3.5.1/alist-linux-musl-amd64.tar.gz";
    sha256 = "074pcpwaqi11h9hvb25xz3fwjz97hkb084b288xs8r3w2j8jlb5x";
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
