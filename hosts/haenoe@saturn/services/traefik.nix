{ ... }:
{
  virtualisation.oci-containers.containers.traefik = {
    autoStart = true;
    image = "traefik:v2.10";
    cmd = [ "--api.insecure=true" "--providers.docker" ];
    ports = [ "80:80" "8080:8080" ];
    volumes = [ "/run/docker.sock:/var/run/docker.sock" ];
    cmd = [ 
      "--api.insecure=true" 
      "--providers.docker=true"
      "--providers.docker.exposedbydefault=false"
      "--entrypoints.websecure.address=:443"
      "--entrypoints.web.address=:80"
      "--entrypoints.web.http.redirections.entryPoint.to=websecure"
      "--entrypoints.web.http.redirections.entryPoint.scheme=https"
    ];
  };
}
