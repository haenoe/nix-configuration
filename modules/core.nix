{ pkgs, lib, ... }: {

  # Locale
  time.timeZone = lib.mkDefault "Europe/Berlin";
  i18n.defaultLocale = "en_US.UTF-8";

  services.xserver.xkbVariant = "dvorak";
  console.useXkbConfig = true;

  environment.systemPackages = [ pkgs.fd pkgs.alacritty pkgs.neovim ];

  networking.networkmanager.enable = true;

  programs.zsh.enable = true;

  users.users.haenoe.shell = pkgs.zsh;
  users.mutableUsers = false;

  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "23.05";
}
