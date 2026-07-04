{ inputs, ... }: {
  flake.nixosModules.NahalPackages = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      # ── System / CLI ─────────────────────────────────────────
      neovim                        # Terminal editor
      git                           # Version control
      curl                          # HTTP client
      wget                          # File downloader
      yazi                          # Terminal file manager
      ttyper                        # Typing speed test
      caligula                       # ISO/USB flasher
      bluetui                       # Bluetooth TUI client
      zoxide
      direnv
      fzf                           # Command-line fuzzy finder
      lsd                           # Modern replacement for 'ls'
      bat                           # Syntax highlighting 'cat' clone
      ripgrep                       # Fast recursive search tool

      # ── Desktop / GUI ────────────────────────────────────────
      inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
      vscode                        # IDE / code editor
      
      # ── Productivity ─────────────────────────────────────────
      libreoffice                   # Office suite
      zotero
      obsidian
      foliate                       # E-book reader
      papers                        # Document viewer
     

      # ── Graphics / Design ────────────────────────────────────
      blender                       # 3D modeling / rendering
      gimp                          # Image editor
      inkscape                      # Vector graphics editor
      krita                         # Digital painting

      # ── Audio / Video ────────────────────────────────────────
      zrythm                        # Digital audio workstation
      shortwave                     # Internet radio player
      kdePackages.kdenlive          # Video editor

      # ── Communications ────────────────────────────────────────
      vesktop
      whatsie
      thunderbird

      # ── Gaming ───────────────────────────────────────────────
      steam
      steam-run
      gamemode                      # GameMode — automatic game optimisations
      mangohud                      # MangoHud — performance overlay (FPS, temps)
      wineWow64Packages.waylandFull        # Wine (stable) for running Windows games
      winetricks                    # Wine configuration helper
      lutris                        # Game manager with Wine/Proton support
      protonup-qt                   # Proton GE installer
      prismlauncher                 # Game launcher for Minecraft, supporting multiple versions and modpacks
    ];

    # ── Gaming services ──────────────────────────────────────
    security.pam.services.steam.enable = true;
    programs.gamemode.enable = true;
    programs.steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      localNetworkGameTransfers.openFirewall = true;
    };
  };

  flake.nixosModules.NahalZenPackages = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      # ── System / CLI ─────────────────────────────────────────
      neovim                        # Terminal editor
      git                           # Version control
      curl                          # HTTP client
      wget                          # File downloader
      yazi                          # Terminal file manager
      ttyper                        # Typing speed test
      caligula                       # ISO/USB flasher
      bluetui                       # Bluetooth TUI client
      zoxide
      direnv
      fzf                           # Command-line fuzzy finder
      lsd                           # Modern replacement for 'ls'
      bat                           # Syntax highlighting 'cat' clone
      ripgrep                       # Fast recursive search tool

      # ── Desktop / GUI ────────────────────────────────────────
      inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
      vscode                        # IDE / code editor
      
      # ── Productivity ─────────────────────────────────────────
      libreoffice                   # Office suite
      zotero
      obsidian
      foliate                       # E-book reader
      papers                        # Document viewer
     

      # ── Graphics / Design ────────────────────────────────────
      blender                       # 3D modeling / rendering
      gimp                          # Image editor
      inkscape                      # Vector graphics editor
      krita                         # Digital painting

      # ── Audio / Video ────────────────────────────────────────
      zrythm                        # Digital audio workstation
      shortwave                     # Internet radio player
      kdePackages.kdenlive          # Video editor
      obs-studio                    # Video recording / streaming
      tenacity                      # Audio editor / recorder (Audacity fork)

      # ── Communications ────────────────────────────────────────
      vesktop
      whatsie
      thunderbird

      # ── Gaming ───────────────────────────────────────────────
      steam
      steam-run
      gamemode                      # GameMode — automatic game optimisations
      mangohud                      # MangoHud — performance overlay (FPS, temps)
      glfw                          # OpenGL for Wayland.
      wine-wayland                  # Wine (stable) for running Windows games with Wayland support
      wineWow64Packages.waylandFull # Wine (stable) for running Windows games
      winetricks                    # Wine configuration helper
      lutris                        # Game manager with Wine/Proton support
      protonup-qt                   # Proton GE installer
    ];

    # ── Gaming services ──────────────────────────────────────
    security.pam.services.steam.enable = true;
    programs.gamemode.enable = true;
    programs.gamescope = {
      enable = true;
      capSysNice = true;
    };
    programs.steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      gamescopeSession.enable = true;
      localNetworkGameTransfers.openFirewall = true;
    };
  };
}