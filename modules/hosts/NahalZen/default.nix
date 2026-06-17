{ self, inputs, ... }: {
  flake.nixosConfigurations.NahalZen = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.NahalZenConfiguration
    ];
  };
}
