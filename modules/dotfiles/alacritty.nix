{ ... }: {
  programs.alacritty = {
    enable = true;
    settings = {
      env = {
        TERM = "xterm-256color";
      };
      font = {
        size = 11.00;
        normal.family = "Iosevka Term Nerd Font";
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
