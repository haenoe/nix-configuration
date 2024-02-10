{hostInformation, ...}: {
  services.syncthing = {
    enable = true;
    user = hostInformation.mainUser;
    dataDir = "/home/${hostInformation.mainUser}/syncthing";
    overrideDevices = true;
    overrideFolders = true;
    settings.devices = {
      alpha = {
        id = "ZK5D52Y-I4LZ47T-GPLPGHX-YV2WDT6-YUQKJU4-WFLTHEA-XZTZ5QY-IKQQWQS";
      };
      macbook = {
        id = "EBN75BC-BDNOKMA-OQQSFYB-V5YQSCV-NE6F4TG-QUUMNVB-DJ4FU5J-CBMMKQA";
      };
    };
    settings.folders = {
      aegis-backup = {
        id = "n73tt-4phja";
        path = "/home/haenoe/backups/aegis";
        devices = ["alpha"];
      };
      vault = {
        id = "tz2g5-tw3uo";
        path = "/home/haenoe/documents/vault";
        devices = ["macbook"];
      };
    };
  };
}
