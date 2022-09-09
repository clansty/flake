{ inputs, ... }:
{
  imports = [ inputs.xremap-flake.nixosModules.default ];
  services.xremap = {
    serviceMode = "user";
    withGnome = true;
    watch = true;
    userName = "clansty";
    deviceName = "HOLTEK USB-HID AP";
    config = {
      modmap = [
        {
          name = "Global";
          remap = {
            CapsLock = "Ctrl_L";
            Alt_L = "Win_L";
            Win_L = "Alt_L";
          };
        }
      ];
    };
  };
}
