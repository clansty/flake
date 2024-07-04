{ pkgs, ... }:
{
  boot.loader.systemd-boot = {
    extraFiles =
      let
        package = pkgs.fetchzip {
          url = "https://github.com/DavidS95/Smokeless_UMAF/raw/c003b126cab6e29b1d72d061d59cea9e721a6910/UniversalAMDFormBrowser.zip";
          sha256 = "sha256-/zbmWR3dHo5efRvNaqqzFThVod95mBOeA8spB6KgSFI=";
          stripRoot = false;
        };
      in
      {
        "EFI/UMAF/bootx64.efi" = "${package}/EFI/Boot/Bootx64.efi";
        "UiApp.efi" = "${package}/UiApp.efi";
        "SetupBrowser.efi" = "${package}/SetupBrowser.efi";
        "DisplayEngine.efi" = "${package}/DisplayEngine.efi";
      };

    extraEntries."umaf.conf" = ''
      title UMAF
      efi /EFI/UMAF/bootx64.efi
      sort-key z_umaf
    '';
  };
}
