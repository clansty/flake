{ pkgs, ... }:
{
  systemd.services.npiperelay = {
    wantedBy = [ "multi-user.target" ];
    after = [ "mnt-d.mount" ];
    serviceConfig = {
      ExecStart = with pkgs;"${pkgs.socat}/bin/socat EXEC:\"/mnt/d/opt/bin/npiperelay.exe -ei -s //./pipe/ssh-pageant\" UNIX-LISTEN:/tmp/openssh-ssh-agent.socket,unlink-close,unlink-early,fork";
      UMask = 0;
    };
  };

  environment.sessionVariables.SSH_AUTH_SOCK = "/tmp/openssh-ssh-agent.socket";
}
