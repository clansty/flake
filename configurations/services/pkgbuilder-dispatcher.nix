{ pkgs, lib, ... }:
let
  repo = builtins.fetchGit {
    url = "https://github.com/Clansty/Needy-Builder-Overdose.git";
    rev = "deef384c9575e5067b12d49f19b429550e783b98";
    ref = "main";
  };
  program = pkgs.callPackage "${repo}/dispatcher" { };
  pacman-fix = pkgs.pacman.overrideAttrs (attrs: {
    postInstall = with pkgs;''
      installShellCompletion --bash scripts/pacman --zsh scripts/_pacman
      wrapProgram $out/bin/makepkg \
        --prefix PATH : ${lib.makeBinPath [ 
          binutils 
          coreutils 
          git 
          autoconf
          automake
          curl
        ]}
      wrapProgram $out/bin/pacman-key \
        --prefix PATH : ${lib.makeBinPath [
          "${placeholder "out"}"
          coreutils
          gawk
          gettext
          gnugrep
          gnupg
        ]}
    '';
  });
in
{
  users = {
    users.dispatcher = {
      isNormalUser = true;
      group = "dispatcher";
      uid = 6666;
    };
    groups.dispatcher = { };
  };

  environment.systemPackages = [ pacman-fix ];

  systemd.services.dispatcher = {
    description = "dispatcher service";
    wantedBy = [ "multi-user.target" ];
    after = [ "network.target" ];
    path = with pkgs;[ pacman-fix openssh git bash coreutils-full ];
    environment = {
      CONFIG = "/pkgbuilder-work/config.yaml";
    };
    serviceConfig = {
      User = "dispatcher";
      Group = "dispatcher";
      Restart = "no";
      ExecStart = "${program}/bin/dispatcher";
    };
  };

}
