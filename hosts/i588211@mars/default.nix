{ mainUser, ... }:
{
  imports = [ 
    ../../users/${mainUser}
  ];

  home = {
    username = mainUser;
    homeDirectory = "/Users/${mainUser}";

    stateVersion = "23.05";

    packages = [ ];

    file = { };

    sessionVariables = { };
  };

  programs.home-manager.enable = true;
}
