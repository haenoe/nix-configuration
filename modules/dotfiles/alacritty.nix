{lib, ...}: {
  programs.alacritty = {
    enable = true;
    settings = {
      env = {
        TERM = "xterm-256color";
      };
      font = {
        size = lib.mkDefault 11.00;
        normal.family = lib.mkDefault "Iosevka Term Nerd Font";
      };
      window = {
        padding = {
          x = 15;
          y = 10;
        };
      };
    };
  };
}
