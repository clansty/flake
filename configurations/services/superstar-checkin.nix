{ inputs, ... }:
{
  imports = [ inputs.superstar-checkin.nixosModules.default ];
  services.superstar-checkin = (import ../utils/secrets.nix).superstar;
}
