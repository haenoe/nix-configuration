{ ... }:
{
  programs.wezterm = {
    enable = true;
    extraConfig = ''
      local wezterm = require('wezterm')

      local config = wezterm.config_builder()

      config.use_fancy_tab_bar = false 
      config.font = wezterm.font 'IosevkaTerm NFM'
      config.font_size = 12.0

      config.color_scheme = 'Gruber (base16)'

      return config
    '';
  };
}
