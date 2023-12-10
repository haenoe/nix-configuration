{ pkgs, hostInformation, ... }: {
  services.xserver = {
    enable = true;
    windowManager.bspwm.enable = true;
    displayManager = {
      lightdm.enable = true;
      sessionCommands = "${pkgs.xorg.xrandr}/bin/xrandr --output DP-0 --mode 1920x1080 --rate 144";
    };
  };

  home-manager.users.${hostInformation.mainUser} = {
    xsession = {
      enable = true;
      windowManager.bspwm = {
        enable = true;
        monitors = {
          DP-0 = [
            "1"
            "2"
            "3"
            "4"
          ];
        };
        rules = {
          "Pcmanfm" = {
            state = "floating";
          };
        };
      };
    };
    services = {
      sxhkd = {
        enable = true;
        extraOptions = [ "-m -1" ];
        keybindings = {
          "alt + Return" = "${pkgs.wezterm}/bin/wezterm";
          "alt + space" = "${pkgs.rofi}/bin/rofi -show drun";
          "alt + q" = "${pkgs.bspwm}/bin/bspc node -c";
          "alt + {_, shift +} + {a,o,e,u}" = "${pkgs.bspwm}/bin/bspc {desktop -f, node -d} {1-4}";
          "alt + {_, shift +} + {h,j,k,l}" = "${pkgs.bspwm}/bin/bspc node -{f,s} {west,south,north,east}";
          "super + {t,shift + t,s,f}" = "${pkgs.bspwm}/bin/bspc node -t {tiled,pseudo_tiled,floating,fullscreen}";
        };
      };
    };
  };
}
