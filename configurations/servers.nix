{ deploy-rs, self, ... }@inputs:
let
  mkNode = { name, host, remoteBuild ? false }: {
    inherit name;
    value = {
      hostname = host;
      inherit remoteBuild;
      profiles.system = {
        path =
          let config = self.nixosConfigurations.${name};
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
      name = "pgsql";
      host = "11.11.1.4";
    }
  ]);
}
