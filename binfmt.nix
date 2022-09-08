{ pkgs, ... }:
{
  boot.binfmt.registrations = {
    x86_64 = {
      interpreter = "${pkgs.exagear}/bin/64";
      magicOrExtension = ''\x7fELF\x02\x01\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x00\x3e\x00'';
      mask = ''\xff\xff\xff\xff\xff\xfe\xfe\x00\xff\xff\xff\xff\xff\xff\xff\xff\xfe\xff\xff\xff'';
      wrapInterpreterInShell = false;
    };
    i386 = {
      interpreter = "${pkgs.exagear}/bin/32";
      magicOrExtension = ''\x7fELF\x01\x01\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x00\x03\x00'';
      mask = ''\xff\xff\xff\xff\xff\xfe\xfe\x00\xff\xff\xff\xff\xff\xff\xff\xff\xfe\xff\xff\xff'';
      wrapInterpreterInShell = false;
    };
  };

  nix.extraOptions = ''
    extra-platforms = x86_64-linux i686-linux
  '';
  nix.settings.extra-sandbox-paths = [
    "/run/binfmt/x86_64=${pkgs.exagear}/bin/64"
    "/run/binfmt/i386=${pkgs.exagear}/bin/32"
  ];
}
