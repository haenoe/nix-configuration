{ ... }: {
  programs.alacritty = {
    enable = true;
    settings = {
      env = {
        TERM = "xterm-256color";
      };
      font = {
        size = 12.00;
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
