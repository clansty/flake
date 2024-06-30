{
  imports = [
    ./ssh.nix
  ];

  services.openssh.listenAddresses = [{
    addr = "0.0.0.0";
    port = 222;
  }];

  users.users.clansty.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFtxin+PG+8N3gG9tFb8aKLS7NHOoecmUIS7x0pCwrmf"
  ];
}
