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
    ../../core
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
  hardware.opengl.enable = true;
  hardware.nvidia = {
    package = config.boot.kernelPackages.nvidiaPackages.stable;
    modesetting.enable = true;
  };

  networking.hostName = "mercury";

  users.users.${userName} = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" ];
    password = "foo";
  };
}
