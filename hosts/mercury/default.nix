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

  boot.loader.systemd-boot.enable = true;

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
