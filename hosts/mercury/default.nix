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
    ./i3.nix
    ../../users/${userName}
    ./hardware-configuration.nix
  ];

  # Boot config
  boot.loader = {
    efi = {
      canTouchEfiVariables = true;
    };
    grub = {
      enable = true;
      useOSProber = true;
      devices = [ "nodev" ];
    };
  };

  # Nvidia GPU specific config  
  services.xserver.videoDrivers = [ "nvidia" ];
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

  system.stateVersion = "23.05";
}
