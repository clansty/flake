{ pkgs, config, ... }: {
  programs.nushell = {
    enable = true;
    configFile.source = ./config.nu;
    envFile.source = ./env.nu;
    extraEnv = ''
      let starship_cache = "${config.xdg.cacheHome}/starship"
      if not ($starship_cache | path exists) {
        mkdir $starship_cache
      }
      ${pkgs.starship}/bin/starship init nu | save --force ${config.xdg.cacheHome}/starship/init.nu
    '';
    extraConfig = ''
      use ${config.xdg.cacheHome}/starship/init.nu
    '';
  };

  programs.carapace.enable = true;
}
