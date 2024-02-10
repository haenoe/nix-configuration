{
  pkgs,
  lib,
  hostInformation,
  hostName,
  nur,
  agenix,
  home-manager,
  nix-index-database,
  ...
}: {
  imports = [
    nur.nixosModules.nur
    agenix.nixosModules.default
    home-manager.nixosModules.home-manager
    nix-index-database.nixosModules.nix-index
    ./fonts.nix
  ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = {
      inherit hostInformation hostName;
    };
  };

  programs.nix-ld.enable = true;

  programs.command-not-found.enable = false;

  time.timeZone = lib.mkDefault "Europe/Berlin";

  i18n.defaultLocale = lib.mkDefault "en_US.UTF-8";
  console = {
    useXkbConfig = true;
    keyMap = lib.mkDefault "dvorak";
  };

  services.xserver.xkb.variant = lib.mkForce "dvorak";

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

  environment.systemPackages = with pkgs; [fd alacritty neovim pavucontrol];

  networking = {
    inherit hostName;
    networkmanager.enable = true;
  };

  programs.zsh.enable = true;

  users.users.${hostInformation.mainUser} = {
    isNormalUser = true;
    extraGroups = ["networkmanager" "wheel" "audio"];
    shell = pkgs.zsh;
  };
  users.mutableUsers = false;

  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = lib.mkDefault false;
    };
  };

  security.sudo.wheelNeedsPassword = false;

  nix = {
    settings = {
      experimental-features = ["nix-command" "flakes"];
      trusted-users = ["root" "@wheel"];
    };
  };

  systemd.services.NetworkManager-wait-online.enable = lib.mkForce false;
  systemd.services.systemd-networkd-wait-online.enable = lib.mkForce false;

  # nixpkgs.config.allowUnfree = true;

  system.stateVersion = "23.11";
}
