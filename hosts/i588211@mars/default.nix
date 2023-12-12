{ mainUser, ... }:
{
  imports = map (module: ../../modules/dotfiles + "${module}") [
    "/direnv.nix"
    "/wezterm.nix"
    "/zsh.nix"
    "/ssh.nix"
    "/neovim"
  ];

  home = {
    username = mainUser;
    homeDirectory = "/Users/${mainUser}";

    stateVersion = "23.05";

    packages = [ ];

    file = { };

    sessionVariables = { };
  };

  programs.home-manager.enable = true;
}
