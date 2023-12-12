{ ... }: {
  services.picom = {
    enable = true;
    settings = {
      # corner-radius = 16.0;
      # opacity-rule = [ "75:class_g = 'Alacritty'"  ];

      blur = { method = "gaussian"; size = 10; deviation = 5.0; };
    };
  };
}
