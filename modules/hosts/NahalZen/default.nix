{ self, inputs, ... }: {
  flake.nixosConfigurations.NahalZen = inputs.nixpkgs.lib.nixosSystem {
    specialArgs = { inherit inputs; };
    modules = [
      self.nixosModules.NahalZenConfiguration
      self.nixosModules.NahalZenPackages
      self.nixosModules.NahalZenMango
      self.nixosModules.NahalZenNoctalia
    ];
  };
}
