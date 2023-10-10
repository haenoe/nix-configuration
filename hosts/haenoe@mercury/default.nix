{ config, hostInformation, pkgs, ... }:
{
  imports = [
    ./bspwm.nix
    ../../users/${hostInformation.mainUser}
    ../../modules/syncthing.nix
    ./hardware-configuration.nix
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.tmp.useTmpfs = true;

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

  environment.systemPackages = with pkgs; [
    pkgs.pcmanfm
    pkgs.obsidian
  ];

  services.tailscale.enable = true;

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
    extraGroups = [ "networkmanager" "wheel" "audio" ];
    openssh.authorizedKeys.keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILdmY6zsT3hIn8S/NAfhvOfDcCd5BINhstTamPTc/fA9 max.mechler@sap.com" ];
  };

  security.sudo.wheelNeedsPassword = false;
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    trusted-users = [ "root" "@wheel" ];
  };
}
