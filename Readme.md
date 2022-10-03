# 凌莞的 Nix Flake

包含我自己的配置和打包的一些软件包，适用于 [NixOS](https://nixos.org) 和 [nix-darwin](https://github.com/LnL7/nix-darwin)

## 使用 overlay

```nix
# flake.nix
{
    inputs.clansty.url = "github:clansty/flake";
    outputs = inputs: {
        nixosConfigurations.<machine-name> = {
            # ...
            modules = [
                # ...
                {
                    nixpkgs.overlays = [ inputs.clansty.overlays.clansty ];
                    environment.systemPackages = [ pkgs.yesplaymusic ]; # Something in `packages` dir of this repo
                }
            ];
        };
    };
}
```

