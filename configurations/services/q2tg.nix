{ inputs, ... }:
{
  imports = [ inputs.q2tg.nixosModules.default ];
  services.q2tg = {
    enable = true;
  } // (import ../utils/secrets.nix).q2tg;
}
