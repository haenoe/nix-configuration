{ home-manager, lib, pkgs, ... }: {
  services.xserver = {
    enable = true;
    windowManager.bspwm.enable = true;
    displayManager = { 
      lightdm.enable = true; 
      sessionCommands = "${pkgs.xorg.xrandr}/bin/xrandr --output DP-0 --mode 1920x1080 --rate 144";
    };
  };

  home-manager.users.haenoe = {
    xsession = {
      enable = true;
      windowManager.bspwm = {
        enable = true;
      };
    };
    services = {
      polybar = {
        enable = true;
        script = ''
          polybar &
        '';
      };
      sxhkd = {
        enable = true;
        keybindings = {
          "alt + Return" = "alacritty";
          "alt + space" = "${pkgs.rofi}/bin/rofi -show drun";
          "alt + q" = "${pkgs.bspwm}/bin/bspc node -c";
          "alt + {_, shift +} + {h,j,k,l}" = "${pkgs.bspwm}/bin/bspc node -{f,s} {west,east,north,south}";
        };
      };
    };
  };
}
