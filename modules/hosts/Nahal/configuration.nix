{self, pkgs, ... }: {

  flake.nixosModules.NahalConfiguration = { config, pkgs, lib, ... }: {
    imports = [
      self.nixosModules.NahalHardware
    ];

  # Experimental features.
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Latest Xanmod kernel for desktop responsiveness
  boot.kernelPackages = pkgs.linuxPackages_xanmod_latest;

  # Bootloader.
   boot.loader = {
    grub = {
      enable = true;
      device = "nodev";
      efiSupport = true;
      copyKernels = true;
      extraConfig = ''
        search --no-floppy --set=root --file /vmlinuz
        linux /vmlinuz root=UUID=e9e38657-1d34-4fa8-acbb-a24d4fe816e5 ro quiet
        initrd /initrd
      '';
    };
    efi.canTouchEfiVariables = true;
  };

  # Networking.
  networking.networkmanager.enable = true;
  networking.hostName = "Nahal";

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
  
  #gnome specific tweaks
  environment.sessionVariables = {
    GSK_RENDERER = "gl"; # Prevents protocol errors between GNOME and Nvidia Wayland
    SDL_VIDEODRIVER = "x11"; # Forces Gamescope to fallback smoothly onto XWayland
  };

  # Enable non-redistributable firmware (required for Intel WiFi/BT).
  hardware.enableRedistributableFirmware = true;

  # OpenGL / VA-API acceleration (handled by NVIDIA).
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  # NVIDIA GPU — GIGABYTE G5 MD has an NVIDIA RTX 3050/3050 Ti.
  # Configured as the primary GPU via NVIDIA Prime sync.
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;
    powerManagement.finegrained = false;
    open = true;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.beta;   # Latest beta driver;

    # Prime sync — NVIDIA handles all rendering, Intel drives the display panel.
    prime = {
      sync.enable = true;
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";
    };
  };

  # Early KMS (Kernel Mode Setting) — NVIDIA handles display via nvidia_drm.
  boot.initrd.kernelModules = [ "nvidia" "nvidia_drm" ];

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

  # GIGABYTE G5 MD-specific kernel parameters.
  boot.kernelParams = [
    "nvidia_drm.fbdev=1"            # NVIDIA framebuffer console
    "nvidia_drm.modeset=1"          # NVIDIA DRM modesetting
    "pcie_aspm=force"               # Active State Power Management
    "acpi_osi=Linux"                # Better ACPI compatibility
  ];

  # Additional kernel modules for GIGABYTE G5 MD hardware.
  boot.kernelModules = [
    "nvidia"                        # NVIDIA GPU
    "nvidia_drm"                    # NVIDIA DRM (modesetting)
    "nvidia_modeset"                # NVIDIA modeset
    "nvidia_uvm"                    # NVIDIA Unified Memory
    "i915"                          # Intel GPU (display output only)
    "iwlwifi"                       # Intel WiFi
    "r8169"                         # Realtek RTL8168H Ethernet
    "snd-hda-intel"                 # HD Audio (Tiger Lake-H)
    "snd-soc-skylake"               # Skylake+ audio support
  ];

  # Firmware for Intel WiFi.
  hardware.firmware = with pkgs; [
    linux-firmware                  # General Linux firmware (includes Intel WiFi)
  ];

  # ========== END HARDWARE DRIVERS ==========

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

  system.stateVersion = "26.05";
  };
}