{ mainUser, ... }:
{
  home.username = mainUser;
  home.homeDirectory = "/Users/${mainUser}";

  home.stateVersion = "23.05";

  home.packages = [ ];

  home.file = { };

  home.sessionVariables = { };

  programs.home-manager.enable = true;
}
