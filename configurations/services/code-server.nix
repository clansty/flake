{ ... }:
{
  services.code-server = {
    enable = true;
    user = "clansty";
    port = 3344;
    host = "0.0.0.0";
    auth = "none";
  };
}