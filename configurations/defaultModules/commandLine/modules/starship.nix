{ pkgs, lib, config, ... }:
let
  catppuccin = pkgs.fetchFromGitHub {
    owner = "catppuccin";
    repo = "starship";
    rev = "ca2fb0600730fd3958a2cb4d4ca97c401877b365";
    sha256 = "sha256-KzXO4dqpufxTew064ZLp3zKIXBwbF8Bi+I0Xa63j/lI=";
  };
in
{
  programs.starship = {
    enable = true;
    settings = {
      character = {
        success_symbol = "[➜ ](bold green)";
        error_symbol = "[➜ ](bold red)";
      };
      add_newline = true;
      time.disabled = false;
      status.disabled = false;
      shell.disabled = false;
      fill.symbol = " ";
      format = lib.concatStrings [
        "$username$hostname$localip$shlvl$singularity$kubernetes$directory$vcsh$fossil_branch$fossil_metrics$git_branch$git_commit$git_state$git_metrics$git_status$hg_branch$pijul_channel$docker_context$fill"
        "$all$time$line_break"
        "$shell$jobs$status$os$container$character"
      ];
    } // lib.importTOML "${catppuccin}/palettes/macchiato.toml";
    presets = [
      "nerd-font-symbols"
    ];
  };

  environment.sessionVariables.STARSHIP_CONFIG =
    # https://github.com/NixOS/nixpkgs/blob/nixos-unstable/nixos/modules/programs/starship.nix#L4
    let
      cfg = config.programs.starship;

      settingsFormat = pkgs.formats.toml { };

      userSettingsFile = settingsFormat.generate "starship.toml" cfg.settings;

      settingsFile = if cfg.presets == [ ] then userSettingsFile else
      pkgs.runCommand "starship.toml"
        {
          nativeBuildInputs = [ pkgs.yq ];
        } ''
        tomlq -s -t 'reduce .[] as $item ({}; . * $item)' \
          ${lib.concatStringsSep " " (map (f: "${cfg.package}/share/starship/presets/${f}.toml") cfg.presets)} \
          ${userSettingsFile} \
          > $out
      '';
    in
    settingsFile;
}
