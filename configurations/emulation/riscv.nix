{ pkgs, ... }:
{
  boot.binfmt.emulatedSystems = [ "riscv64-linux" ];
  environment.systemPackages = with pkgs; [
    qemu
  ];
}
