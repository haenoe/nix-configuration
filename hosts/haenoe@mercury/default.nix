{ config
, lib
, specialArgs
, options
, modulesPath
, pkgs
, home-manager
}:
{
  imports = [
    ./bspwm.nix
    ../../users/haenoe
    ./hardware-configuration.nix
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];

  # Boot config
  # boot.loader = {
  #   efi = {
  #     canTouchEfiVariables = true;
  #     efiSysMountPoint = "/boot";
  #   };
  #   grub = {
  #     enable = true;
  #     efiSupport = true;
  #     useOSProber = true;
  #     devices = [ "nodev" ];
  #   };
  # };

  # Nvidia GPU specific config  
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.opengl.enable = true;
  hardware.nvidia = {
    modesetting.enable = true;
    open = true;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  networking.hostName = "mercury";

  services.openssh.enable = true;

  users.users.haenoe = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" ];
    password = "foo";
    openssh.authorizedKeys.keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILNRp42Uzw6MYuZcY62s2VS0Awa+pABLd5XB5GoJgOuY programmierhaenoe@outlook.de" ];
  };

  security.sudo.wheelNeedsPassword = false;
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    trusted-users = [ "root" "@wheel" ];
  };
}
