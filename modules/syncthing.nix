{ pkgs, ... }:
{
  services.syncthing = { 
    enable = true;
    user = "haenoe";
    dataDir = "/home/haenoe/syncthing";
    overrideDevices = true;
    overrideFolders = true;
    settings.devices = {};
    settings.folders = {};
  };
}
