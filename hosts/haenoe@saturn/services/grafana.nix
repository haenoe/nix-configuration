{hostName, ...}: {
  virtualisation.oci-containers.containers.grafana = {
    autoStart = true;
    image = "grafana/grafana-oss:9.5.12";
    dependsOn = ["traefik"];
    volumes = [
      "grafana-storage:/var/lib/grafana"
    ];
    extraOptions = [
      "-ltraefik.enable=true"
      "-ltraefik.http.routers.grafana.rule=Host(`grafana.${hostName}.haenoe.party`)"
      "-ltraefik.http.routers.grafana.entrypoints=websecure"
      "-ltraefik.http.routers.grafana.tls=true"
      "-ltraefik.http.routers.grafana.tls.certresolver=cfresolver"
      "--network=internal"
    ];
  };
}
