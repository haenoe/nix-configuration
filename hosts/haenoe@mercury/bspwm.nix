{ home-manager, userName, lib, pkgs, ... }: {
  services.xserver = {
    enable = true;
    windowManager.bspwm.enable = true;
    displayManager.lightdm.enable = true;
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
          "alt + Return" = "alacritty";
          "alt + space" = "${pkgs.rofi}/bin/rofi -show drun";
          "alt + q" = "${pkgs.bspwm}/bin/bspc node -c";
          "alt + {_, shift +} + {h,j,k,l}" = "${pkgs.bspwm}/bin/bspc node -{f,s} {west,east,north,south}";
        };
      };
    };
  };
}
