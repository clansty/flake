{ inputs, ... }:
{
  imports = [ inputs.superstar-checkin.nixosModules.default ];
  services.superstar-checkin = import /home/clansty/superstar.nix;
}
