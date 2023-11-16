{ home-manager, pkgs, ... }: {
  home-manager.users.haenoe = {
    imports = [
      ./alacritty.nix
      ./git.nix
      ./rofi.nix
      ./firefox.nix
      ./chromium.nix
      ../shared/wezterm.nix
      ../shared/zsh.nix
      ./picom.nix
      ./polybar.nix
      ./gtk.nix
      ./xdg.nix
      ./ssh.nix
      ../shared/neovim
    ];
    home = {
      username = "haenoe";
      homeDirectory = "/home/haenoe";
      stateVersion = "23.05";
    };
  };
}
