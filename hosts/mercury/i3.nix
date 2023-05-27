{ home-manager, userName, ... }: {
  home-manager.users.${userName}.xsession.windowManager.i3.enable = true;
}
