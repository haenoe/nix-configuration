{ hostName, hostInformation, ... }:
{
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
    environment = { };
    ports = [ "${hostInformation.address}:80:80" "${hostInformation.address}:443:443" ];
    volumes = [ "/run/docker.sock:/var/run/docker.sock:ro" "/etc/traefik/letsencrypt:/letsencrypt" ];
    extraOptions = [
      "-ltraefik.enable=true"
      "-ltraefik.http.routers.dashboard.rule=Host(`traefik.${hostName}.haenoe.party`)"
      "-ltraefik.http.routers.dashboard.service=api@internal"
      "-ltraefik.http.routers.dashboard.entrypoints=websecure"
      "-ltraefik.http.routers.dashboard.tls=true"
      "-ltraefik.http.routers.dashboard.tls.certresolver=cfresolver"
    ];
  };

  virtualisation.oci-containers.containers.whoami = {
    autoStart = true;
    image = "traefik/whoami";
    dependsOn = [ "traefik" ];
    extraOptions = [
      "-ltraefik.enable=true"
      "-ltraefik.http.routers.whoami.rule=Host(`whoami.${hostName}.haenoe.party`)"
      "-ltraefik.http.routers.whoami.entrypoints=websecure"
      "-ltraefik.http.routers.whoami.tls=true"
      "-ltraefik.http.routers.whoami.tls.certresolver=cfresolver"
    ];
  };
}
