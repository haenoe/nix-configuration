{ hostName, ... }:
{
  virtualisation.oci-containers.containers.paperless-ngx-redis = {
    autoStart = true;
    image = "redis:7";
    volumes = [
      "paperless-ngx-redis-data:/data"
    ];
    extraOptions = [
      "--network=internal"
      "--hostname=redis.paperless-ngx.${hostName}.internal"
    ];
  };

  virtualisation.oci-containers.containers.paperless-ngx-postgres = {
    autoStart = true;
    image = "postgres:15";
    volumes = [
      "paperless-ngx-postgres-data:/var/lib/postgresql/data"
    ];
    environment = {
      POSTGRES_DB = "paperless";
      POSTGRES_USER = "paperless";
      POSTGRES_PASSWORD = "paperless";
    };
    extraOptions = [
      "--network=internal"
      "--hostname=postgres.paperless-ngx.${hostName}.internal"
    ];
  };

  virtualisation.oci-containers.containers.paperless-ngx = {
    autoStart = true;
    image = "ghcr.io/paperless-ngx/paperless-ngx:1.17.4";
    dependsOn = [
      "traefik"
      "paperless-ngx-redis"
      "paperless-ngx-postgres"
      "paperless-ngx-gotenberg"
      "paperless-ngx-tika"
    ];
    environment = {
      PAPERLESS_REDIS = "redis://redis.paperless-ngx.${hostName}.internal:6379";
      PAPERLESS_DBHOST = "postgres.paperless-ngx.${hostName}.internal";
      PAPERLESS_TIKA_ENABLED = 1;
      PAPERLESS_TIKA_GOTENBERG_ENDPOINT = "http://gotenberg.paperless-ngx.${hostName}.internal";
      PAPERLESS_TIKA_ENDPOINT = "http://tika.paperless-ngx.${hostName}.internal";
    };
    volumes = [
      "paperless-ngx-data:/usr/src/paperless/data"
      "paperless-ngx-media:/usr/src/paperless/media"
    ];
    extraOptions = [
      "-ltraefik.enable=true"
      "-ltraefik.http.routers.uptimekuma.rule=Host(`paperless-ngx.${hostName}.haenoe.party`)"
      "-ltraefik.http.routers.uptimekuma.entrypoints=websecure"
      "-ltraefik.http.routers.uptimekuma.tls=true"
      "-ltraefik.http.routers.uptimekuma.tls.certresolver=cfresolver"
      "--network=internal"
    ];
  };

  virtualisation.oci-containers.containers.paperless-ngx-gotenberg = {
    autoStart = true;
    image = "gotenberg/gotenberg:7.8";
    cmd = [
      "gotenberg"
      "--chromium-disable-javascript=true"
      "--chromium-allow-list=file:///tmp/.*"
    ];
    extraOptions = [
      "--network=internal"
      "--hostname=gotenberg.paperless-ngx.${hostName}.internal"
    ];
  };

  virtualisation.oci-containers.containers.paperless-ngx-tika = {
    autoStart = true;
    image = "ghcr.io/paperless-ngx/tika:2.9.0-minimal";
    extraOptions = [
      "--network=internal"
      "--hostname=tika.paperless-ngx.${hostName}.internal"
    ];
  };
}
