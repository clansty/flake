{ deploy-rs, self, ... }@inputs:
let
  mkNode = { name, host, remoteBuild ? true }: {
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
      host = "clansty-nextcloud.net.men.ci";
    }
    {
      name = "repo-legacy-server";
      host = "clansty-repo.net.men.ci";
    }
    {
      name = "repo-dispatcher";
      host = "repo-dispatcher.net.men.ci";
    }
    {
      name = "repo-builder";
      host = "172.16.0.87";
    }
    {
      name = "nas";
      host = "172.16.0.70";
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
