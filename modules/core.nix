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

  sound.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    jack.enable = true;
  };

  environment.systemPackages = with pkgs; [ fd alacritty neovim pavucontrol ];

  networking.networkmanager.enable = true;

  programs.zsh.enable = true;

  users.users.${hostInformation.mainUser}.shell = pkgs.zsh;
  users.mutableUsers = false;

  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "23.11";
}
