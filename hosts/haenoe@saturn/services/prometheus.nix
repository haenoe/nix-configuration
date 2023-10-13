{ hostName, ... }:
{
  virtualisation.oci-containers.containers.prometheus = {
    autoStart = true;
    image = "prom/prometheus:v2.47.1";
    dependsOn = [ "traefik" ];
    volumes = [
      "/etc/prometheus/prometheus.yml:/etc/prometheus/prometheus.yml"
      "prometeus-data:/prometheus"
    ];
    extraOptions = [
      "-ltraefik.enable=true"
      "-ltraefik.http.routers.whoami.rule=Host(`prometheus.${hostName}.haenoe.party`)"
      "-ltraefik.http.routers.whoami.entrypoints=websecure"
      "-ltraefik.http.routers.whoami.tls=true"
      "-ltraefik.http.routers.whoami.tls.certresolver=cfresolver"
      "--add-host=host.docker.internal:host-gateway"
    ];
  };

  services.prometheus.exporters.node = {
    enable = true;
  };

  environment.etc."/prometheus/prometheus.yml".text = ''
    global:
      scrape_interval: 15s

    scrape_configs:
      - job_name: 'node_exporter'
        scrape_interval: 5s
        static_configs:
          - targets: [ 'saturn.haenoe.party:9100' ]
  '';
}

