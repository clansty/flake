{
  imports = map (name: import ./modules/${name}) (builtins.attrNames (builtins.readDir ./modules));
}
