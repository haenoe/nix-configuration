{ config, hostInformation, pkgs, ... }:
{
  imports = [
    ./restic.nix
    ../../users/${hostInformation.mainUser}
    ../../modules/syncthing.nix
    ../../modules/bspwm.nix
    ./hardware-configuration.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.tmp.useTmpfs = true;

  services.prometheus.exporters.node = {
    enable = true;
  };

  programs.nix-ld.enable = true;

  networking.firewall.allowedUDPPorts = [ 51820 ];

  networking.wireguard.interfaces.cloud = {
    ips = [ "192.168.177.2/24" ];
    listenPort = 51820;
    privateKeyFile = "/home/haenoe/wg-keys/private";
    mtu = 1384;
    peers = [
      {
        publicKey = "O3M3xHYIheQ29wSqG5NXN2GfSLG0QYmLRCIaiAgNHSo=";
        allowedIPs = [ "192.168.177.0/24" ];
        endpoint = "202.61.236.225:51820";
      }
    ];
  };

  environment.systemPackages = with pkgs; [
    pcmanfm
    obsidian
    discord
    jetbrains.clion
    zotero
  ];

  programs.kdeconnect = {
    enable = true;
  };

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
