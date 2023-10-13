{ hostName, ... }:
{
  virtualisation.oci-containers.containers.grafana = {
    autoStart = true;
    image = "grafana/grafana-oss:9.5.12";
    dependsOn = [ "traefik" ];
    volumes = [
      "grafana-storage:/var/lib/grafana"
    ];
    extraOptions = [
      "-ltraefik.enable=true"
      "-ltraefik.http.routers.whoami.rule=Host(`grafana.${hostName}.haenoe.party`)"
      "-ltraefik.http.routers.whoami.entrypoints=websecure"
      "-ltraefik.http.routers.whoami.tls=true"
      "-ltraefik.http.routers.whoami.tls.certresolver=cfresolver"
    ];
  };
}
