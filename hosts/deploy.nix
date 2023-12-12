{ self, deploy-rs, inputs }:
let
  lib = inputs.nixpkgs.lib;
in
{
  user = "root";
  autoRollback = false;
  nodes = lib.mapAttrs
    (hostName: { address, system, mainUser, ... }:
      {
        hostname = address;
        profiles.system = {
          sshUser = mainUser;
          path = deploy-rs.lib.${system}.activate.nixos self.nixosConfigurations.${hostName};
        };
      }
    )
    (lib.attrsets.filterAttrs (_: v: v.deploy == true) self.hosts);
}
