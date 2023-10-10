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
    ];
  };

  virtualisation.oci-containers.containers.node-exporter = {
    autoStart = true;
    image = "prom/node-exporter:v1.6.1";
    dependsOn = [ "traefik" "prometheus" ];
    volumes = [
      "/:/host:ro,rslave"
    ];
    extraOptions = [
      "-ltraefik.enable=true"
      "-ltraefik.http.routers.whoami.rule=Host(`${hostName}.haenoe.party`) && PathPrefix(`/metrics`)"
      "-ltraefik.http.routers.whoami.entrypoints=websecure"
      "-ltraefik.http.routers.whoami.tls=true"
      "-ltraefik.http.routers.whoami.tls.certresolver=cfresolver"
      "--net=host"
      "--pid=host"
    ];
    cmd = [
      "--path.rootfs=/host"
    ];
  };

  environment.etc."/prometheus/prometheus.yml".text = ''
    
  '';
}

