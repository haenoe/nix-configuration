{ home-manager, userName, lib, pkgs, ... }: {
  services.xserver = {
    enable = true;
    windowManager.bspwm.enable = true;
  };

  home-manager.users.${userName} = {
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
          "super + Return" = "alacritty";
          "super + space" = "${pkgs.rofi}/bin/rofi -show drun";
          "super + q" = "${pkgs.bspwm}/bin/bspc node -c";
          "super + {_, shift +} + {h,j,k,l}" = "${pkgs.bspwm}/bin/bspc node -{f,s} {west,east,north,south}";
        };
      };
    };
  };
}
