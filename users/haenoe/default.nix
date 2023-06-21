{ userName, home-manager, ... }: {
  home-manager.users.${userName} = {
    imports = [
      ./git.nix
      ./rofi.nix
      ./firefox.nix
      ./chromium.nix
      ./neovim
    ];
    home = {
      username = userName;
      homeDirectory = "/home/${userName}";
      stateVersion = "23.05";
    };
  };
}
