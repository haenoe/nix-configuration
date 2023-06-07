{ home-manager, userName, lib, ... }: {
  services.xserver = {
    enable = true;
    windowManager.i3.enable = true;
  };

  home-manager.users.${userName} = {
    xsession.windowManager.i3 = {
      enable = true;
    };
    services.polybar = {
      enable = true;
      script = "polybar bar &";
    };
    xdg.configFile."i3/config".source = lib.mkForce ./config;
  };
}
