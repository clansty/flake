{ ... }:
{
  system.defaults = {
    ActivityMonitor.IconType = 6;
    LaunchServices.LSQuarantine = false;
    NSGlobalDomain = {
      AppleMeasurementUnits = "Centimeters";
      AppleShowAllExtensions = true;
      AppleShowScrollBars = "Automatic";
      AppleTemperatureUnit = "Celsius";
      NSNavPanelExpandedStateForSaveMode = true;
      NSNavPanelExpandedStateForSaveMode2 = true;
    };
    finder = {
      AppleShowAllExtensions = true;
      FXDefaultSearchScope = "SCcf";
      FXEnableExtensionChangeWarning = false;
      FXPreferredViewStyle = "Nlsv";
      QuitMenuItem = true;
      ShowPathbar = true;
      ShowStatusBar = true;
    };
    loginwindow = {
      LoginwindowText = "nya~";
      PowerOffDisabledWhileLoggedIn = true;
      RestartDisabledWhileLoggedIn = true;
      ShutDownDisabledWhileLoggedIn = true;
    };
  };
  environment.etc = {
    sudoers = {
      enable = true;
      text = ''
        Defaults        env_reset
        Defaults        env_keep += "BLOCKSIZE"
        Defaults        env_keep += "COLORFGBG COLORTERM"
        Defaults        env_keep += "__CF_USER_TEXT_ENCODING"
        Defaults        env_keep += "CHARSET LANG LANGUAGE LC_ALL LC_COLLATE LC_CTYPE"
        Defaults        env_keep += "LC_MESSAGES LC_MONETARY LC_NUMERIC LC_TIME"
        Defaults        env_keep += "LINES COLUMNS"
        Defaults        env_keep += "LSCOLORS"
        Defaults        env_keep += "SSH_AUTH_SOCK"
        Defaults        env_keep += "TZ"
        Defaults        env_keep += "DISPLAY XAUTHORIZATION XAUTHORITY"
        Defaults        env_keep += "EDITOR VISUAL"
        Defaults        env_keep += "HOME MAIL"
        root            ALL = (ALL) ALL
        %admin          ALL = (ALL) NOPASSWD:ALL
      '';
    };
  };
}