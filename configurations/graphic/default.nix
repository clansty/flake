{ arch, ... }:

{
    imports =
        [ 
            ./displayManager.nix
            ./desktop.nix
            ./apps.nix
            ./fonts.nix
            ./ime.nix
            ./fingerprint.nix
        ] ++ (
            if arch == "x86_64" then [
                ./apps-x86.nix
            ] else []
        ) ++ (
            if arch == "aarch64" then [
                ./apps-arm.nix
                ./google-keys.nix
            ] else []
        );
}

