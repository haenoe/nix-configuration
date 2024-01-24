{ config, hostInformation, pkgs, nixos-hardware, stylix, ... }:
{
  imports = [
    ./restic.nix
    ../../modules/syncthing.nix
    ../../modules/x11/i3.nix
    ./hardware-configuration.nix
    nixos-hardware.nixosModules.common-cpu-amd
    nixos-hardware.nixosModules.common-pc-ssd
    stylix.nixosModules.stylix
  ];

  home-manager.users.${hostInformation.mainUser} = {
    imports = map (module: ../../modules/dotfiles + "${module}") [
      "/alacritty.nix"
      "/git.nix"
      "/rofi.nix"
      "/firefox.nix"
      "/chromium.nix"
      "/direnv.nix"
      "/wezterm.nix"
      "/zsh.nix"
      "/picom.nix"
      "/polybar.nix"
      "/gtk.nix"
      "/xdg.nix"
      "/ssh.nix"
      "/neovim"
    ];
    home = {
      username = hostInformation.mainUser;
      homeDirectory = "/home/${hostInformation.mainUser}";
      stateVersion = "23.05";
    };
  };

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];

  stylix.image = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/NixOS/nixos-artwork/f07707cecfd89bc1459d5dad76a3a4c5315efba1/wallpapers/nix-wallpaper-nineish-dark-gray.png";
    sha256 = "sha256-nhIUtCy/Hb8UbuxXeL3l3FMausjQrnjTVi1B3GkL9B8=";
  };
  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/embers.yaml";

  boot.tmp.useTmpfs = true;

  services.prometheus.exporters.node = {
    enable = true;
  };

  networking.firewall.allowedUDPPorts = [ 51820 ];

  networking.wireguard.interfaces.cloud = {
    ips = [ "192.168.177.2/24" ];
    listenPort = 51820;
    privateKeyFile = "/home/haenoe/wg-keys/private";
    mtu = 1384;
    peers = [
      {
        publicKey = "O3M3xHYIheQ29wSqG5NXN2GfSLG0QYmLRCIaiAgNHSo=";
        allowedIPs = [ "192.168.177.0/24" ];
        endpoint = "202.61.236.225:51820";
      }
    ];
  };

  environment.systemPackages = with pkgs; [
    pcmanfm
    obsidian
    discord
    jetbrains.clion
    zotero
  ];

  programs.kdeconnect = {
    enable = true;
  };

  services.tailscale.enable = true;

  # Nvidia GPU specific config  
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.opengl.enable = true;
  hardware.nvidia = {
    modesetting.enable = true;
    open = true;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  services.openssh.enable = true;

  users.users.${hostInformation.mainUser} = {
    openssh.authorizedKeys.keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILdmY6zsT3hIn8S/NAfhvOfDcCd5BINhstTamPTc/fA9 max.mechler@sap.com" ];
  };
}
