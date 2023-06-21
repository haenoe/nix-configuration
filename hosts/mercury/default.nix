{ config
, lib
, specialArgs
, options
, modulesPath
, pkgs
, userName
, home-manager
}:
{
  imports = [
    ./bspwm.nix
    ../../users/${userName}
    ./hardware-configuration.nix
  ];

  # Boot config
  boot.loader = {
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot";
    };
    grub = {
      enable = true;
      efiSupport = true;
      useOSProber = true;
      devices = [ "nodev" ];
    };
  };

  # Nvidia GPU specific config  
  services.xserver.videoDrivers = [ "nvidia" ];
  services.xserver.xkbVariant = "dvorak";
  hardware.opengl.enable = true;
  hardware.nvidia = {
    package = config.boot.kernelPackages.nvidiaPackages.stable;
    modesetting.enable = true;
  };

  networking.hostName = "mercury";

  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Berlin";
  i18n.defaultLocale = "en_US.UTF-8";

  console.keyMap = "dvorak";

  users.users.${userName} = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" ];
    password = "foo";
  };

  environment.systemPackages = [ pkgs.fd pkgs.wezterm pkgs.alacritty ];

  system.stateVersion = "23.05";
}
