{self, pkgs, ... }: {

  flake.nixosModules.NahalSDDM = { pkgs, lib, ... }: {
  
    # Enable SDDM display manager.
    services.displayManager.sddm = {
      enable = true;
      wayland = true;  # Enable Wayland support for Plasma
    };
  };
}