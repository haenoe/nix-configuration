{ ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ./services/traefik.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "saturn";

  virtualisation = {
    docker = { 
      enable = true;
      enableOnBoot = true;
      autoPrune.enable = true;
    };
    oci-containers.backend = "docker";
  };

  users.users.haenoe = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" "audio" "docker" ];
    openssh.authorizedKeys.keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIE5laWkCjzbloX88KuPDJprh9AkHAFnPUGfEuTZyxjtp haenoe@mercury" ];
  };

  services.openssh = { 
    enable = true;
    settings.PasswordAuthentication = false;
    settings.KbdInteractiveAuthentication = false;
  };

  security.sudo.wheelNeedsPassword = false;

  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    trusted-users = [ "root" "@wheel" ];
  };
}