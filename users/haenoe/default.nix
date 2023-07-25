{ userName, home-manager, ... }: {
  home-manager.users.${userName} = {
    imports = [
      ./alacritty.nix
      ./git.nix
      ./rofi.nix
      ./firefox.nix
      ./chromium.nix
      ./zsh.nix
      ./picom.nix
      ./neovim
    ];
    home = {
      username = userName;
      homeDirectory = "/home/${userName}";
      stateVersion = "23.05";
    };
  };
}
