{ ... }:
{
  virtualisation.oci-containers.containers.homer = {
    autoStart = true;
    image = "b4bz/homer:v23.09.1";
    dependsOn = [ "traefik" ];
    volumes = [
      "/etc/homer:/www/assets"
    ];
    extraOptions = [
      "-ltraefik.enable=true"
      "-ltraefik.http.routers.homer.rule=Host(`homer.saturn.haenoe.party`)"
      "-ltraefik.http.routers.homer.entrypoints=websecure"
      "-ltraefik.http.routers.homer.tls=true"
      "-ltraefik.http.routers.homer.tls.certresolver=cfresolver"
      "--network=internal"
    ];
  };

  environment.etc.homer = {
    source = ./assets;
  };
}
