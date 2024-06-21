{ inputs, ... }:
{
  imports = [ inputs.xremap-flake.nixosModules.default ];
  services.xremap = {
    serviceMode = "user";
    withGnome = true;
    watch = true;
    userName = "clansty";
    config = {
      virtual_modifiers = [ "CapsLock" ];
      modmap = [
        {
          name = "CapsLock in apps other then terminal";
          remap.CapsLock = "Ctrl_L";
          application.not = "org.gnome.Console";
        }
      ];
      keymap = [
        {
          name = "Terminal";
          remap = {
            CapsLock-c = "Ctrl-Shift-c";
            CapsLock-v = "Ctrl-Shift-v";
            CapsLock-t = "Ctrl-Shift-t";
            CapsLock-w = "Ctrl-Shift-w";
            CapsLock-f = "Ctrl-Shift-f";
            CapsLock-1 = "Alt-1";
            CapsLock-2 = "Alt-2";
            CapsLock-3 = "Alt-3";
            CapsLock-4 = "Alt-4";
            CapsLock-5 = "Alt-5";
            CapsLock-6 = "Alt-6";
            CapsLock-7 = "Alt-7";
            CapsLock-Shift-s = "Ctrl-Shift-s";
          };
          # application.only = "Chromium-browser";
          application.only = "org.gnome.Console";
        }
      ];
    };
  };
}
