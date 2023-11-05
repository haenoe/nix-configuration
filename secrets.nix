let
  mercury = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIM4AzaVgNYLprK+gJ6fNmKTGIiwJ05NnX7S40BmZTCt8";
  systems = [
    mercury
  ];
in
{
  "secret1.age".publicKeys = systems;
}
