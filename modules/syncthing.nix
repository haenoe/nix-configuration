{ pkgs, hostInformation, ... }:
{
  services.syncthing = {
    enable = true;
    user = hostInformation.mainUser;
    dataDir = "/home/${hostInformation.mainUser}/syncthing";
    overrideDevices = true;
    overrideFolders = true;
    settings.devices = { };
    settings.folders = { };
  };
}
