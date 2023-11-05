{ hostName, ... }:
{
  virtualisation.oci-containers.containers.actual = {
    autoStart = true;
    image = "ghcr.io/actualbudget/actual-server:23.10.0";
    dependsOn = [ "traefik" ];
    volumes = [
      "actual-data:/data"
    ];
    labels = {
      "traefik.enable" = "true";
      "traefik.http.routers.actual.rule" = "Host(`actual.${hostName}.haenoe.party`)";
      "traefik.http.routers.actual.entrypoints" = "websecure";
      "traefik.http.routers.actual.tls" = "true";
      "traefik.http.routers.actual.tls.certresolver" = "cfresolver";
    };
    environment = {
      TZ = "Europe/Berlin";
    };
    extraOptions = [
      "--network=internal"
    ];
  };
}
