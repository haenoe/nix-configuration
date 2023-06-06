{ home-manager, userName, ... }: {
  services.xserver = {
    enable = true;
    windowManager.i3.enable = true;
  };

  home-manager.users.${userName}.xsession.windowManager.i3.enable = true;
}
