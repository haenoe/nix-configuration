{ pkgs, hostInformation, lib, ... }: {
  services.xserver.displayManager.sessionCommands = ''
    ${pkgs.xorg.xrandr}/bin/xrandr --output DP-0 --mode 1920x1080 --rate 144
  '';

  services.xserver = {
    enable = true;
    windowManager.i3.enable = true;
  };

  home-manager.users.${hostInformation.mainUser} = {
    xsession.windowManager.i3 = {
      enable = true;
      config = {
        modifier = "Mod1";
        terminal = lib.getExe pkgs.wezterm;
        gaps = {
          inner = 5;
          outer = 5;
        };
      };
    };
  };
}
