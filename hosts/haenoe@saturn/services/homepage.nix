{hostName, ...}: {
  virtualisation.oci-containers.containers.homepage = {
    autoStart = true;
    image = "ghcr.io/gethomepage/homepage:v0.7.3";
    dependsOn = ["homepage"];
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
        - Traefik:
            icon: traefik.png
            href: https://traefik.saturn.haenoe.party
            description: Reverse proxy dashboard
            widget:
              type: traefik
              url: https://traefik.saturn.haenoe.party
        - Grafana:
            icon: grafana.png
            href: https://grafana.saturn.haenoe.party
            description: Analytics and visualizations
        - Prometheus:
            icon: prometheus.png
            href: https://prometheus.saturn.haenoe.party
            description: Metrics collection
        - Uptime Kuma:
            icon: uptime-kuma.png
            href: https://uptimekuma.saturn.haenoe.party
            description: Uptime and monitoring
        - Gotify:
            icon: gotify.png
            href: https://gotify.saturn.haenoe.party
            description: Notification server
      - Management:
        - Paperless NGX:
            icon: paperless-ngx.png
            href: https://paperless-ngx.saturn.haenoe.party
            description: Document management
        - Stirling PDF:
            icon: stirling-pdf.png
            href: https://stirling-pdf.saturn.haenoe.party
            description: PDF mangler
        - Actual Budget:
            icon: actual.png
            href: https://actual.saturn.haenoe.party
            description: Financial management
        - Vaultwarden:
            icon: vaultwarden-light.png
            href: https://vault.pluto.haenoe.party
            description: Password manager
      - External:
        - Nextcloud:
            icon: nextcloud.png
            href: https://cloud.ext.haenoe.party
            description: Files, contacts, calendars, ...
    '';
    mode = "0440";
  };
}
