{ ... }:
{
  virtualisation.oci-containers.containers.uptimekuma = {
    autoStart = true;
    image = "louislam/uptime-kuma:1.23.2-alpine";
    dependsOn = [ "traefik" ];
    volumes = [
      "uptimekuma/app/data"
    ];
    extraOptions = [
      "-ltraefik.enable=true"
      "-ltraefik.http.routers.uptimekuma.rule=Host(`uptimekuma.saturn.haenoe.party`)"
      "-ltraefik.http.routers.uptimekuma.entrypoints=websecure"
      "-ltraefik.http.routers.uptimekuma.tls=true"
      "-ltraefik.http.routers.uptimekuma.tls.certresolver=cfresolver"
    ];
  };
}
