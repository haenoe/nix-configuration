{ ... }:
{
  programs.wezterm = {
    enable = true;
    extraConfig = ''
      local wezterm = require('wezterm')

      local config = wezterm.config_builder()

      local function is_vim(pane)
        return pane:get_user_vars().IS_NVIM == 'true'
      end

      local direction_keys = {
        Left = 'h',
        Down = 'j',
        Up = 'k',
        Right = 'l',
        h = 'Left',
        j = 'Down',
        k = 'Up',
        l = 'Right',
      }

      local function split_nav(key)
        return {
          key = key,
          mods = 'CTRL',
          action = wezterm.action_callback(function(win, pane)
            if is_vim(pane) then
              -- pass the keys through to vim/nvim
              win:perform_action({
                SendKey = { key = key, mods = 'CTRL' },
              }, pane)
            else
              win:perform_action({ ActivatePaneDirection = direction_keys[key] }, pane)
            end
          end),
        }
      end

      config.keys = {
        split_nav('h'),
        split_nav('j'),
        split_nav('k'),
        split_nav('l'),
      }

      config.use_fancy_tab_bar = false 

      config.font = wezterm.font 'IosevkaTerm NFM'
      config.font_size = 16.0

      return config
    '';
  };
}
