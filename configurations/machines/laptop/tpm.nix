{ pkgs, ... }: {
  security.tpm2.enable = true;
  security.tpm2.pkcs11.enable = true;
  security.tpm2.tctiEnvironment.enable = true;
  users.users.clansty.extraGroups = [ "tss" ];

  environment.systemPackages = with pkgs;[ tpm2-tools ];

  programs.ssh.extraConfig = "PKCS11Provider /run/current-system/sw/lib/libtpm2_pkcs11.so";
}
