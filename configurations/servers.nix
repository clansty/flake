{ deploy-rs, self, ... }@inputs:
let
  mkNode = { name, host, remoteBuild ? false }: {
    inherit name;
    value = {
      hostname = host;
      inherit remoteBuild;
      profiles.system = {
        path =
          let config = self.nixosConfigurations."clansty-${name}";
          in deploy-rs.lib.${config.pkgs.system}.activate.nixos config;
      };
    };
  };
in
{
  sshUser = "clansty";
  user = "root";
  autoRollback = false;
  magicRollback = false;
  checks = [];
  nodes = builtins.listToAttrs (map mkNode [
    {
      name = "nixserver";
      host = "nixsrv";
    }
    {
      name = "nextcloud";
      host = "11.11.1.10";
    }
    {
      name = "repo-legacy-server";
      host = "11.11.1.32";
    }
    {
      name = "repo-dispatcher";
      host = "11.11.1.30";
    }
    {
      name = "nas";
      host = "11.11.1.3";
    }
    {
      name = "pgsql";
      host = "172.16.0.82";
    }
    # {
    #   name = "w510";
    #   host = "w510";
    # }
  ]);
}
