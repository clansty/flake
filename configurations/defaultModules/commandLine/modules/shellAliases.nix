{ pkgs, ... }:
with pkgs;{
  environment = {
    shellAliases = {
      ":q" = "exit";
      ":wq" = "exit";
      ls = "${eza}/bin/eza --color-scale --group-directories-first --time-style iso -bH";
      l = "ls -l";
      ll = "l";
      la = "l -a";
      nrbu = "nrb --recreate-lock-file";
    };

    sessionVariables = {
      EDITOR = "${neovim}/bin/nvim";
      SUDO_EDITOR = "${neovim}/bin/nvim";
      ZSH_AUTOSUGGEST_STRATEGY = "history completion";
      PRISMA_SCHEMA_ENGINE_BINARY = "${prisma-engines}/bin/schema-engine";
      PRISMA_QUERY_ENGINE_BINARY = "${prisma-engines}/bin/query-engine";
      PRISMA_QUERY_ENGINE_LIBRARY = "${prisma-engines}/lib/libquery_engine.node";
      PRISMA_INTROSPECTION_ENGINE_BINARY = "${prisma-engines}/bin/introspection-engine";
      PRISMA_FMT_BINARY = "${prisma-engines}/bin/prisma-fmt";
    };
  };
}
