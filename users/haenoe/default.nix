{ home-manager, pkgs, ... }: {
  home-manager.users.haenoe = {
    imports = [
      ./alacritty.nix
      ./git.nix
      ./rofi.nix
      ./firefox.nix
      ./chromium.nix
      ./wezterm.nix
      ./zsh.nix
      ./picom.nix
      ./polybar.nix
      ./xdg.nix
      ./neovim
    ];
    home = {
      username = "haenoe";
      homeDirectory = "/home/haenoe";
      stateVersion = "23.05";
    };
  };
}
