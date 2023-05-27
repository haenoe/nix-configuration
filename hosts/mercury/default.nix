{ config, lib, specialArgs, options, modulesPath, pkgs, userName, home-manager }: {
  imports = [ ./hyprland.nix ];

  fileSystems."/" = { };

  boot.loader.systemd-boot.enable = true;

  networking.hostName = "mercury";

  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Berlin";
  i18n.defaultLocale = "en_US.UTF-8";

  console.keyMap = "dvorak";

  users.users.${userName} = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" ];
  };

  system.stateVersion = "23.11";
}
