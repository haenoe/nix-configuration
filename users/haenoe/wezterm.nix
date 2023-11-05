{ ... }:
{
  services.wezterm = {
    enable = true;
    extraConfig = ''
      local wezterm = require('wezterm')

      local config = {}

      config.font = wezterm.font 'Iosevka Term Nerd Font Mono'
      config.font_size = 16.0

      config.color_scheme = 'Gruber (base16)'
      config.key_map_preference = 'Physical'

      return config
    '';
  };
}
