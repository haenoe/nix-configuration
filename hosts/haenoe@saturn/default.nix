{hostInformation, ...}: {
  imports = [
    ./hardware-configuration.nix
    ./services/traefik.nix
    ./services/uptimekuma.nix
    ./services/grafana.nix
    ./services/prometheus.nix
    ./services/homepage.nix
    ./services/gotify.nix
    ./services/paperless-ngx.nix
    ./services/actual.nix
    ./services/homer
  ];

  home-manager.users.${hostInformation.mainUser} = {
    imports = map (module: ../../modules/dotfiles + "${module}") [
      "/git.nix"
      "/direnv.nix"
      "/zsh.nix"
    ];
    home = {
      username = hostInformation.mainUser;
      homeDirectory = "/home/${hostInformation.mainUser}";
      stateVersion = "23.05";
    };
  };

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "saturn";

  networking.firewall.allowedUDPPorts = [51820];

  networking.wireguard.interfaces.cloud = {
    ips = ["192.168.177.1/24"];
    listenPort = 51820;
    privateKeyFile = "/home/haenoe/wg-keys/private";
    mtu = 1420;
    peers = [
      {
        publicKey = "9UiO9DKg9CO0zdSQDHq6PA6dbApIpHWsvl4oKHhkaks=";
        allowedIPs = ["192.168.177.2/32"];
      }
      {
        publicKey = "78+iMco6H37Wt6wNoL8qaUu6JdKsTucm+ylo2DxFuQ0=";
        allowedIPs = ["192.168.177.3/32"];
      }
    ];
  };

  virtualisation = {
    docker = {
      enable = true;
      enableOnBoot = true;
      autoPrune.enable = true;
    };
    oci-containers.backend = "docker";
  };

  users.users.haenoe = {
    # isNormalUser = true;
    extraGroups = ["networkmanager" "wheel" "audio" "docker"];
    openssh.authorizedKeys.keys = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIE5laWkCjzbloX88KuPDJprh9AkHAFnPUGfEuTZyxjtp haenoe@mercury"];
  };

  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = false;
    settings.KbdInteractiveAuthentication = false;
  };

  services.tailscale.enable = true;

  security.sudo.wheelNeedsPassword = false;

  nix.settings = {
    experimental-features = ["nix-command" "flakes"];
    trusted-users = ["root" "@wheel"];
  };
}
