{ pkgs, lib, hostInformation, hostName, ... }: {
  imports = [
    ./fonts.nix
  ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = {
      inherit hostInformation hostName;
    };
  };

  time.timeZone = lib.mkDefault "Europe/Berlin";

  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    useXkbConfig = true;
    keyMap = lib.mkForce "dvorak";
  };

  services.xserver.xkbVariant = lib.mkForce "dvorak";

  sound.enable = true;
  hardware.pulseaudio.enable = true;

  environment.systemPackages = [ pkgs.fd pkgs.alacritty pkgs.neovim ];

  networking.networkmanager.enable = true;

  programs.zsh.enable = true;

  users.users.${hostInformation.mainUser}.shell = pkgs.zsh;
  users.mutableUsers = false;

  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "23.11";
}
