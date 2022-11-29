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
  ]);
}
