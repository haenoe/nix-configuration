let
  mercury = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIM4AzaVgNYLprK+gJ6fNmKTGIiwJ05NnX7S40BmZTCt8";
  systems = [
    mercury
  ];
  haenoe = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIE5laWkCjzbloX88KuPDJprh9AkHAFnPUGfEuTZyxjtp";
  users = [
    haenoe
  ];
in
{
  "hosts/haenoe@mercury/repository-key.age".publicKeys = systems ++ users;
}
