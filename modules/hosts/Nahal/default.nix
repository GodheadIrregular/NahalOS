{ self, inputs, ... }: {
  flake.nixosConfigurations.Nahal = inputs.nixpkgs.lib.nixosSystem {
    specialArgs = { inherit inputs; };
    modules = [
      self.nixosModules.NahalConfiguration
      self.nixosModules.NahalPackages
      self.nixosModules.NahalGnome
      self.nixosModules.NahalPlasma
      self.nixosModules.NahalSDDM
    ];
  };
}
