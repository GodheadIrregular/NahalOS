{self, pkgs, ... }: {

  flake.nixosModules.NahalZenConfiguration = { pkgs, lib, ... }: {
    imports = [
      self.nixosModules.NahalZenHardware
    ];
  
  # Experimental features.
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Zen kernel for desktop responsiveness.
  boot.kernelPackages = pkgs.linuxPackages_zen;

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

  # ── Fonts ─────────────────────────────────────────────────
  fonts.packages = with pkgs; [
    noto-fonts                   # Comprehensive font family
    noto-fonts-cjk-sans          # Chinese / Japanese / Korean support
    noto-fonts-color-emoji       # Noto Color Emoji fallback
    twitter-color-emoji          # Twitter (Twemoji) emoji pack
    maple-mono.NF                # Maple Mono Nerd Font — monospace with Nerd Font icons
    font-awesome                 # Icon font
    material-design-icons        # Material Design icons
    liberation_ttf               # Metric-compatible replacements for Arial, Times, etc.
  ];

  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      serif = [ "Noto Serif" "Liberation Serif" ];
      sansSerif = [ "Noto Sans" "Liberation Sans" ];
      monospace = [ "Maple Mono" "Liberation Mono" ];
      emoji = [ "Twitter Color Emoji" ];
    };
  };

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

  # ========== HARDWARE DRIVERS & OPTIMIZATIONS ==========

  # Enable non-redistributable firmware (required for Intel WiFi/BT).
  hardware.enableRedistributableFirmware = true;

  # Intel GPU / OpenGL / VA-API acceleration.
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      intel-media-driver          # VA-API driver for Intel HD Graphics (Raptor Lake)
      intel-vaapi-driver          # Legacy VA-API driver
      libva-vdpau-driver          # VDPAU wrapper for VA-API
      libvdpau-va-gl              # VDPAU to VA-API bridge
    ];
  };

  # Early KMS (Kernel Mode Setting) for Intel GPU — avoids flicker during boot.
  boot.initrd.kernelModules = [ "i915" ];

  # Intel WiFi firmware (iwlwifi) — loaded automatically when hardware.enableRedistributableFirmware is set.
  # The wlo1 interface will be managed by NetworkManager.

  # Power management.
  powerManagement = {
    enable = true;
    cpuFreqGovernor = "powersave";  # Balanced power saving on a laptop
  };

  # thermald — Intel thermal daemon for better temperature management.
  services.thermald.enable = true;

  # power-profiles-daemon — allows switching between power profiles (power-saver / balanced / performance).
  services.power-profiles-daemon.enable = true;

  # libinput — proper touchpad and touchscreen support.
  services.libinput = {
    enable = true;
    touchpad = {
      naturalScrolling = true;
      disableWhileTyping = true;
      clickMethod = "clickfinger";   # Two-finger right click, three-finger middle click
      accelProfile = "flat";
    };
  };

  # ASUS Zenbook-specific kernel modules and settings.
  boot.kernelParams = [
    "i915.enable_psr=1"             # Panel Self Refresh for power saving
    "i915.enable_fbc=1"             # Framebuffer compression
    "i915.enable_dc=2"              # Deep C-states for power saving
    "i915.fastboot=1"               # Fast boot with Intel GPU
    "pcie_aspm=force"               # Active State Power Management
    "acpi_osi=Linux"                # Better ACPI compatibility
  ];

  # Additional kernel modules for ASUS Zenbook hardware.
  boot.kernelModules = [
    "i915"                          # Intel GPU
    "iwlwifi"                       # Intel WiFi
    "snd-sof-pci"                   # Sound Open Firmware (Raptor Lake audio)
    "snd-hda-intel"                 # HD Audio
    "snd-soc-skylake"               # Skylake+ audio support
    "asus-nb-wmi"                   # ASUS laptop WMI hotkeys
    "asus-wmi"                      # ASUS WMI driver
    "wmi"                           # Windows Management Instrumentation
  ];

  # Firmware for Intel WiFi.
  hardware.firmware = with pkgs; [
    linux-firmware                  # General Linux firmware (includes Intel WiFi)
  ];

  # Enable fprintd for the ELAN fingerprint reader (ETU905A88-E).
  services.fprintd = {
    enable = true;
    package = pkgs.fprintd;
  };


  # Enable Thunderbolt support (already in initrd kernel modules from hardware.nix).
  services.hardware.bolt.enable = true;

  # ========== END HARDWARE DRIVERS ==========

  # Define a user account.
  users.users."lambda" = {
    isNormalUser = true;
    description = "lambda";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
    ];
  };

  # Mango window manager.
  mango.enable = true;

  # Noctalia compositor.
  noctalia.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "26.05";
  };
}