{ pkgs, hostInformation, lib, config, ... }: {
  services.xserver.displayManager.sessionCommands = ''
    ${pkgs.xorg.xrandr}/bin/xrandr --output DP-0 --mode 1920x1080 --rate 144
  '';

  services.xserver = {
    enable = true;
    windowManager.i3.enable = true;
  };

  systemd.user.services.polkit-gnome-authentication-agent-1 = {
    description = "polkit-gnome-authentication-agent-1";
    wantedBy = [ "graphical-session.target" ];
    wants = [ "graphical-session.target" ];
    after = [ "graphical-session.target" ];
    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
      Restart = "on-failure";
      RestartSec = 1;
      TimeoutStopSec = 10;
    };
  };

  home-manager.users.${hostInformation.mainUser} = {
    xsession.enable = true;
    xsession.windowManager.i3 = {
      enable = true;
      config = {
        modifier = "Mod1";
        terminal = lib.getExe pkgs.wezterm;
        bars = [
          {
            inherit (config.home-manager.users.${hostInformation.mainUser}.lib.stylix.i3.bar) colors fonts;
            mode = "dock";
            hiddenState = "hide";
            position = "bottom";
            workspaceButtons = true;
            workspaceNumbers = true;
            statusCommand = "${pkgs.i3status}/bin/i3status";
            trayOutput = "primary";
          }
        ];
        gaps = {
          inner = 5;
          outer = 5;
        };
      };
    };
  };
}
