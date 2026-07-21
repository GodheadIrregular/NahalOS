{self, pkgs, ... }: {

  flake.nixosModules.NahalGDM = { pkgs, lib, ... }: {
  
    # Enable GDM display manager.
    services.displayManager.gdm.enable = true;
  };
}