{ hostName, ... }:
{
  virtualisation.oci-containers.containers.gotify = {
    autoStart = true;
    image = "gotify/server:2.4.0";
    dependsOn = [ "traefik" ];
    volumes = [
      "gotify-data:/app/data"
    ];
    labels = {
      "traefik.enable" = "true";
      "traefik.http.routers.gotify.rule" = "Host(`gotify.${hostName}.haenoe.party`)";
      "traefik.http.routers.gotify.entrypoints" = "websecure";
      "traefik.http.routers.gotify.tls" = "true";
      "traefik.http.routers.gotify.tls.certresolver" = "cfresolver";
    };
    environment = {
      TZ = "Europe/Berlin";
    };
    extraOptions = [
      "--network=internal"
    ];
  };
}
