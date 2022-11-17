{ ... }:
let 
  secrets = import ../utils/secrets.nix;
in
{
  services.code-server = {
    enable = true;
    user = "clansty";
    port = 3344;
    host = "0.0.0.0";
    auth = "none";
    extraArguments = [
      "--cert"
      "${../dotfiles/w510.crt}"
      "--cert-key"
      "${secrets.w510Key}"
    ];
  };
}