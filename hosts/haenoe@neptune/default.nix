{
  hostInformation,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
  ];

  boot = {
    loader.grub = {
      enable = true;
      efiSupport = true;
      zfsSupport = true;
      mirroredBoots = [
        {
          devices = ["nodev"];
          path = "/boot";
        }
        {
          devices = ["nodev"];
          path = "/boot-fallback";
        }
      ];
    };
    loader.efi.canTouchEfiVariables = true;
    supportedFilesystems = ["zfs"];
  };

  home-manager.users.${hostInformation.mainUser} = {
    imports = map (module: ../../modules/dotfiles + "${module}") [
      "/git.nix"
      "/direnv.nix"
      "/zsh.nix"
      "/neovim"
    ];
    home = {
      username = hostInformation.mainUser;
      homeDirectory = "/home/${hostInformation.mainUser}";
      stateVersion = "23.05";
    };
  };

  users.users.haenoe = {
    isNormalUser = true;
    extraGroups = ["wheel"];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIE5laWkCjzbloX88KuPDJprh9AkHAFnPUGfEuTZyxjtp"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILdmY6zsT3hIn8S/NAfhvOfDcCd5BINhstTamPTc/fA9"
    ];
    packages = with pkgs; [
      firefox
      neovim
      powertop
      tree
    ];
  };

  powerManagement = {
    cpuFreqGovernor = "powersave";
    powertop.enable = true;
  };

  services.openssh.enable = true;

  security.sudo.wheelNeedsPassword = false;

  nix.settings = {
    experimental-features = ["nix-command" "flakes"];
    trusted-users = ["root" "@wheel"];
  };

  networking = {
    hostId = "68efc211";
    hostName = "neptune";
    # interfaces.enp1s0.ipv4.addresses = [
    #   {
    #     address = "192.168.178.97";
    #     prefixLength = 24;
    #   }
    # ];
  };
}
