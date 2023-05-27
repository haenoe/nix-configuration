{ userName, home-manager, ... }: {
  home-manager.users.${userName} = {
    imports = [ ];
    home = {
      username = userName;
      homeDirectory = "/home/${userName}";
      stateVersion = "23.05";
    };
  };
}
