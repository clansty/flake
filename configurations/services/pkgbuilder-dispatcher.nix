{ pkgs, lib, ... }:
let
  repo = builtins.fetchGit {
    url = "https://github.com/Clansty/Needy-Builder-Overdose.git";
    rev = "bc1d672dfa8ab063272a3c0e2485d505fb66a3cd";
  };
  program = pkgs.callPackage "${repo}/dispatcher" { };
  pacman-fix = pkgs.pacman.overrideAttrs (attrs: {
    postInstall = with pkgs;''
      installShellCompletion --bash scripts/pacman --zsh scripts/_pacman
      wrapProgram $out/bin/makepkg \
        --prefix PATH : ${lib.makeBinPath [ binutils coreutils git ]}
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
