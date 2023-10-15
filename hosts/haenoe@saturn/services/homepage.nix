{ hostName, ... }:
{
  virtualisation.oci-containers.containers.homepage = {
    autoStart = true;
    image = "ghcr.io/gethomepage/homepage:v0.7.3";
    dependsOn = [ "homepage" ];
    volumes = [
      "/etc/homepage:/app/config"
    ];
    labels = {
      "traefik.enable" = "true";
      "traefik.http.routers.homepage.rule" = "Host(`homepage.${hostName}.haenoe.party`)";
      "traefik.http.routers.homepage.entrypoints" = "websecure";
      "traefik.http.routers.homepage.tls" = "true";
      "traefik.http.routers.homepage.tls.certresolver" = "cfresolver";
    };
    extraOptions = [
      "--network=internal"
    ];
  };

  environment.etc."/homepage/settings.yaml" = {
    text = ''
      title: Dashboard
    '';
    mode = "0440";
  };

  environment.etc."/homepage/services.yaml" = {
    text = ''
      - Monitoring:
        - Grafana:
            icon: grafana.png
            href: https://grafana.saturn.haenoe.party
            description: Analytics and visualizations
        - Uptime Kuma:
            icon: uptime-kuma.png
            href: https://uptimekuma.saturn.haenoe.party
            description: Uptime and monitoring
        - Traefik:
            icon: traefik.png
            href: https://traefik.saturn.haenoe.party
            description: Reverse proxy dashboard
            widget:
              type: traefik
              url: https://traefik.saturn.haenoe.party
    '';
    mode = "0440";
  };
}


