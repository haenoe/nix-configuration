{ deploy-rs, self }:
{
  user = "root";
  # remoteBuild = true;
  autoRollback = false;
  nodes = {
    mercury = {
      hostname = "192.168.122.144";
      profiles.system.path = deploy-rs.lib.x86_64-linux.activate.nixos self.nixosConfigurations.mercury;
    };
    saturn = {
      hostname = "202.61.236.225";
      profiles.system.path = deploy-rs.lib.x86_64-linux.activate.nixos self.nixosConfigurations.saturn;
    };
    # pluto = {
    #   hostname = "192.168.178.71";
    #   profiles.system.path = deploy-rs.lib.aarch64-linux.activate.nixos self.nixosConfigurations.pluto;
    # };
  };
}
