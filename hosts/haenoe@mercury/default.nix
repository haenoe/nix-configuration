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
    ../../users/haenoe
    ./hardware-configuration.nix
  ];

  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/vda";

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
  # services.xserver.videoDrivers = [ "nvidia" ];
  hardware.opengl.enable = true;
  # hardware.nvidia = {
  #   package = config.boot.kernelPackages.nvidiaPackages.stable;
  #   modesetting.enable = true;
  # };

  networking.hostName = "mercury";

  services.openssh.enable = true;

  users.users.${userName} = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" ];
    password = "foo";
    openssh.authorizedKeys.keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILNRp42Uzw6MYuZcY62s2VS0Awa+pABLd5XB5GoJgOuY programmierhaenoe@outlook.de" ];
  };

  security.sudo.wheelNeedsPassword = false;
  nix.settings.trusted-users = [ "root" "@wheel" ];
}
