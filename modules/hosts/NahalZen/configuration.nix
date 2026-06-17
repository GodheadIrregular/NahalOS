{self, pkgs, ... }: {

  flake.nixosModules.NahalZenConfiguration = { pkgs, lib, ... }: {
    imports = [
      self.nixosModules.NahalZenHardware
    ];
  
  # Experimental features.
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Bootloader.
   boot.loader = {
    grub = {
      enable = true;
      device = "nodev";
      efiSupport = true;
    };
    efi.canTouchEfiVariables = true;
  };
  
  # Networking.
  networking.networkmanager.enable = true;
  networking.hostName = "NahalZen";
  
  # Bluetooth.
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
        Experimental = true;        # Enables battery reporting for headsets
        FastConnectable = true;     # Faster reconnections
        JustWorksRepairing = "always";
      };
    };
  };

  # Time zone.
  time.timeZone = "America/Vancouver";

  # Locale properties.
  i18n.defaultLocale = "en_CA.UTF-8";

  # Enabl X11 windowing system.
  services.xserver.enable = true;
  
  # Configure X11 keymap.
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };
  
  # Enable GNOME DE.
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

  # CUPS printing.
  services.printing.enable = true;

  # Pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
    wireplumber.enable = true;
  };

  # Define a user account.
  users.users."lambda" = {
    isNormalUser = true;
    description = "lambda";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
    ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  
  # System Packages
  environment.systemPackages = with pkgs; [
  firefox
  neovim
  wget
  git
  curl
  vscode
  ];

  system.stateVersion = "26.05";
  };
}

