{...}: {
  programs.ssh = {
    enable = true;
    matchBlocks = {
      storagebox = {
        hostname = "u350984.your-storagebox.de";
        user = "u350984";
        port = 23;
      };
      saturn = {
        hostname = "202.61.236.225";
        user = "haenoe";
      };
    };
  };
}
