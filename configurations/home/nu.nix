{ pkgs, config, inputs, ... }: {
  programs.nushell = {
    enable = true;
    envFile.text = ''
      $env.RC_DIR = "${inputs.workspace-config.rc-dir}"
      source ${inputs.workspace-config.rc-dir}/nu/env.nu
    '';
    configFile.text = "source ${inputs.workspace-config.rc-dir}/nu/config.nu";
  };
}
