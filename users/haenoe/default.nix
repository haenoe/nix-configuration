{ home-manager, ... }: {
  home-manager.users.haenoe = {
    imports = [
      ./alacritty.nix
      ./git.nix
      ./rofi.nix
      ./firefox.nix
      ./chromium.nix
      ./zsh.nix
      ./picom.nix
      ./polybar.nix
      ./neovim
    ];
    home = {
      username = "haenoe";
      homeDirectory = "/home/haenoe";
      stateVersion = "23.05";
    };
  };
}
