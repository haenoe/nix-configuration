{ lib, config, hostName, hostInformation, ... }:
{
  age.secrets.cloudflare-api-key = {
    file = ../cloudflare-api-key.age;
    owner = "haenoe";
  };

  virtualisation.oci-containers.containers.traefik = {
    autoStart = true;
    image = "traefik:v2.10";
    cmd = [
      "--api.dashboard=true"
      "--providers.docker=true"
      "--providers.docker.exposedbydefault=false"
      "--entrypoints.websecure.address=:443"
      "--entrypoints.web.address=:80"
      "--entrypoints.web.http.redirections.entryPoint.to=websecure"
      "--entrypoints.web.http.redirections.entryPoint.scheme=https"
      "--certificatesresolvers.cfresolver.acme.email=programmierhaenoe@outlook.de"
      "--certificatesresolvers.cfresolver.acme.storage=/letsencrypt/acme.json"
      "--certificatesresolvers.cfresolver.acme.dnschallenge=true"
      "--certificatesresolvers.cfresolver.acme.dnschallenge.resolvers=1.1.1.1:53,8.8.8.8:53"
      "--certificatesresolvers.cfresolver.acme.dnschallenge.provider=cloudflare"
    ];
    environment = {
      CF_API_EMAIL = "programmierhaenoe@outlook.de";
    };
    environmentFiles = [
      config.age.secrets.cloudflare-api-key.path
    ];
    ports = [ "${hostInformation.address}:80:80" "${hostInformation.address}:443:443" ];
    volumes = [ "/run/docker.sock:/var/run/docker.sock:ro" "/etc/traefik/letsencrypt:/letsencrypt" ];
    labels = {
      "traefik.enable" = "true";
      "traefik.http.routers.dashboard.rule" = "Host(`traefik.${hostName}.haenoe.party`)";
      "traefik.http.routers.dashboard.service" = "api@internal";
      "traefik.http.routers.dashboard.entrypoints" = "websecure";
      "traefik.http.routers.dashboard.tls" = "true";
      "traefik.http.routers.dashboard.tls.certresolver" = "cfresolver";
    };
    extraOptions = [
      "--network=internal"
      "--hostname=traefik.saturn.docker.internal"
    ];
  };

  networking.firewall.trustedInterfaces = [ "internal0" ];

  systemd.services.docker-network-internal = {
    wantedBy = [ "multi-user.target" ];
    after = [ "docker.service" "docker.socket" ];
    requiredBy = map (n: "docker-${n}.service") (lib.attrNames config.virtualisation.oci-containers.containers);
    path = [ config.virtualisation.docker.package ];
    script = ''
      exec docker network create -d bridge -o "com.docker.network.bridge.name"="internal0" internal
    '';
    postStop = ''
      exec docker network rm internal
    '';
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
    };
  };

  virtualisation.oci-containers.containers.whoami = {
    autoStart = true;
    image = "traefik/whoami";
    dependsOn = [ "traefik" ];
    labels = {
      "traefik.enable" = "true";
      "traefik.http.routers.whoami.rule" = "Host(`whoami.${hostName}.haenoe.party`)";
      "traefik.http.routers.whoami.entrypoints" = "websecure";
      "traefik.http.routers.whoami.tls" = "true";
      "traefik.http.routers.whoami.tls.certresolver" = "cfresolver";
    };
  };
}
